package com.thenitro.ngine.display.gameentity.collider {
	import com.thenitro.ngine.collections.LinkedList;
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.Pool;
	
	public final class GridCollider implements ICollider {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _entities:LinkedList;
		private var _checks:Vector.<Entity>;
		
		private var _grid:Vector.<Vector.<Entity>>;
		
		private var _gridSize:int;
		
		private var _width:int;
		private var _height:int;
		
		private var _cells:int;
		
		private var _cols:int;
		private var _rows:int;
		
		public function GridCollider(pWidth:Number, pHeight:Number, 
									 pGridSize:Number) {
			_width  = pWidth;
			_height = pHeight;
			
			_gridSize = pGridSize;
			
			_cols = Math.ceil(_width  / _gridSize);
			_rows = Math.ceil(_height / _gridSize);
			
			_cells = _cols * _rows;
			
			_entities = _pool.get(LinkedList) as LinkedList;
			
			if (!_entities) {
				_entities = new LinkedList();
				_pool.allocate(LinkedList, 1);
			}
			
			_checks   = new Vector.<Entity>();
			_grid     = new Vector.<Vector.<Entity>>();
		};
		
		public function addEntity(pEntity:Entity):void {
			_entities.add(pEntity);
		};
		
		public function removeEntity(pEntity:Entity):void {
			_entities.remove(pEntity);
		};
		
		public function update():void {
			_grid.length   = 0;
			_grid.length   = _cells;
			_checks.length = 0;
			
			var entity:Entity = _entities.first as Entity;
			
			while (entity) {
				var index:int = Math.floor(entity.position.y / _gridSize) * _cols + 
								Math.floor(entity.position.x / _gridSize);
				
				if (index >= _grid.length || index < 0) {
					entity = _entities.next(entity) as Entity;
					continue;
				}
				
				if (_grid[index] == null) {
					_grid[index] = new Vector.<Entity>();
				}
				
				_grid[index].push(entity);
				
				entity = _entities.next(entity) as Entity;
			}
			
			for (var i:int = 0; i < _cols; i++) {
				for (var j:int = 0; j < _rows; j++) {
					checkOneCell(i, j);
					
					checkTwoCells(i, j, i + 1, j    );
					checkTwoCells(i, j, i - 1, j + 1);
					checkTwoCells(i, j, i    , j + 1);
					checkTwoCells(i, j, i + 1, j + 1);
				}
			}
			
			for (var k:int = 0; k < _checks.length; k += 2) {
				var entityA:Entity = _checks[k];
				var entityB:Entity = _checks[k + 1];
				
				if (isColliding(entityA, entityB)) {
					entityA.handleCollision(entityB);
					entityB.handleCollision(entityA);
				}
			}
		};
		
		public function getNearbyEntities(pPosition:Vector2D, 
										  pRadius:Number):Array {
			var result:Array = [];
			
			var currentIndexX:int = Math.round(pPosition.x / _gridSize);
			var currentIndexY:int = Math.round(pPosition.y / _gridSize);
			
			var size:int = Math.ceil(pRadius / _gridSize);
			
			for (var i:int = currentIndexX - size; i < currentIndexX + size; i++) {
				for (var j:int = currentIndexY - size; j < currentIndexX + size; j++) {
					var index:int = j * _cols + i;
					
					if (index < 0 || index >=_grid.length) {
						continue;
					}
					
					var cell:Vector.<Entity> = _grid[index];
					
					if (!cell) {
						continue;
					}
					
					for (var k:int = 0; k < cell.length; k++) {
						if (Vector2D.distanceSquared(cell[k].position, pPosition) < pRadius * pRadius) {
							result.push(cell[k]);
						}
					}
				}
			}
			
			return result;
		};
		
		public function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean {
			if (pEntityA.expired || pEntityB.expired) {
				return false;
			}
			
			if (!pEntityA.radius || !pEntityB.radius) {
				return false;
			}
			
			var radius:Number = pEntityA.radius + pEntityB.radius;
			
			return Vector2D.distanceSquared(pEntityA.position, pEntityB.position) < radius * radius;
		};
		
		private function checkOneCell(pX:int, pY:int):void {			
			var cell:Vector.<Entity> = _grid[pY * _cols + pX];
			
			if (cell == null) {
				return;
			}
			
			for (var i:int = 0; i < cell.length - 1; i++) {
				for (var j:int = i + 1; j < cell.length; j++) {
					_checks.push(cell[i], cell[j]);
				}
			}
		};
		
		private function checkTwoCells(pX1:int, pY1:int, 
									   pX2:int, pY2:int):void {
			if (pX2 >= _cols || pX2 < 0 || pY2 >= _rows) {
				return;
			}
			
			var cellA:Vector.<Entity> = _grid[pY1 * _cols + pX1];
			var cellB:Vector.<Entity> = _grid[pY2 * _cols + pX2];
			
			if (!cellA || !cellB) {
				return;
			}
			
			for (var i:int = 0; i < cellA.length; i++) {
				for (var j:int = 0; j < cellB.length; j++) {
					_checks.push(cellA[i], cellB[j]);
				}
			}
		};
	}
}