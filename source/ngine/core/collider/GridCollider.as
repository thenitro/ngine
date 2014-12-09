package ngine.core.collider {
    import ncollections.LinkedList;

    import ngine.core.Entity;
    import ngine.core.collider.abstract.ICollider;
    import ngine.core.collider.abstract.IColliderParameters;
    import ngine.core.collider.parameters.GridColliderParameters;

    import nmath.vectors.Vector2D;

    import npooling.Pool;

    public class GridCollider implements ICollider {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _parameters:GridColliderParameters;
		
		private var _entities:LinkedList;
		private var _checks:Vector.<Entity>;
		
		private var _grid:Vector.<Vector.<Entity>>;
		
		private var _cells:int;
		
		private var _cols:int;
		private var _rows:int;
		
		public function GridCollider() {
			_entities = _pool.get(LinkedList) as LinkedList;
			
			if (!_entities) {
				_entities = new LinkedList();
				_pool.allocate(LinkedList, 1);
			}
			
			_checks   = new Vector.<Entity>();
			_grid     = new Vector.<Vector.<Entity>>();
		};
		
		public function setup(pParameters:IColliderParameters):void {
			_parameters = pParameters as GridColliderParameters;
			
			//_entities.clean();
			
			_checks.length = 0;
			_grid.length   = 0;
			
			_cols = Math.ceil(_parameters.width  / _parameters.gridSize) + 1;
			_rows = Math.ceil(_parameters.height / _parameters.gridSize) + 1;
			
			_cells = _cols * _rows;
		};
		
		public function addEntity(pEntity:Entity):void {
			_entities.add(pEntity);
		};
		
		public function removeEntity(pEntity:Entity):void {
			_entities.remove(pEntity);
		};
		
		public function update(pElapsed:Number):void {
			_grid.length   = 0;
			_grid.length   = _cells;
			_checks.length = 0;
			
			var entity:Entity = _entities.first as Entity;
			
			while (entity) {
				var index:int = Math.floor(entity.position.y / 
										   _parameters.gridSize) * _cols + 
								Math.floor(entity.position.x / 
										   _parameters.gridSize);
				
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
										  pRadius:Number, 
										  pFilterFunction:Function = null, 
										  pSorted:Boolean = false):Array {
			var result:Array = [];
			
			var currentIndexX:int = Math.ceil(pPosition.x / _parameters.gridSize);
			var currentIndexY:int = Math.ceil(pPosition.y / _parameters.gridSize);
			
			var size:int = Math.ceil(pRadius / _parameters.gridSize);
			
			for (var i:int = currentIndexX - size; i < currentIndexX + size; i++) {
				for (var j:int = currentIndexY - size; j < currentIndexY + size; j++) {
					var index:int = j * _cols + i;
					
					if (index < 0 || index >=_grid.length) {
						continue;
					}
					
					var cell:Vector.<Entity> = _grid[index];
					
					if (!cell) {
						continue;
					}
					
					for (var k:int = 0; k < cell.length; k++) {						
						if (Vector2D.distanceSquared(cell[k].position, pPosition) < 
							pRadius * pRadius) {
							if (pFilterFunction == null || pFilterFunction(cell[k])) {
								result.push(cell[k]);
							}
						}
					}
				}
			}
			
			if (pSorted) {
				result.sort(function(pA:Entity, pB:Entity):int {
					if (Vector2D.distanceSquared(pA.position, pPosition) > 
						Vector2D.distanceSquared(pB.position, pPosition)) {
						return 1;
					}
					
					return -1;
				});
			}
			
			return result;
		};
		
		public function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean {
			if (pEntityA.expired || pEntityB.expired) {
				return false;
			}
			
			if (!pEntityA.size || !pEntityB.size) {
				return false;
			}
			
			return _parameters.colliderMethod(pEntityA, pEntityB);
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