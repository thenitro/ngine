package com.thenitro.ngine.collections.grid {
	import com.thenitro.ngine.pool.Pool;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class Grid implements IGridContainer {
		protected static var _pool:Pool = Pool.getInstance();
		
		private var _rows:Dictionary;
		
		private var _sizeX:uint;
		private var _sizeY:uint;
		
		public function Grid() {
			_rows = new Dictionary();
		};
		
		public function get sizeX():uint {
			return _sizeX;
		};
		
		public function get sizeY():uint {
			return _sizeY;
		};
		
		public function get reflection():Class {
			return Grid;
		};
		
		public function add(pX:uint, pY:uint, pObject:IGridObject):IGridObject {
			var cols:Dictionary = takeCols(pX);
				cols[pY] = pObject;
			
			if (pY >= _sizeY) {
				_sizeY = pY + 1;
			}
			
			if (pObject) {
				pObject.updateIndex(pX, pY);
			}
			
			return pObject;
		};
		
		public function take(pX:uint, pY:uint):IGridObject {
			var cols:Dictionary = _rows[pX];
			
			if (!cols) {
				return null;
			}
			
			return cols[pY];
		};
		
		public function addVisual(pObject:IGridObject):void {};
		public function removeVisual(pObject:IGridObject):void {};
		
		public function remove(pX:uint, pY:uint):void {
			var  cols:Dictionary = _rows[pX];
			if (!cols) {
				return;
			}
			
			delete cols[pY];
		};
		
		public function update():void {};
		
		public function swap(pObjectAX:uint, pObjectAY:uint, 
							 pObjectBX:uint, pObjectBY:uint):void {
			var objectA:IGridObject = take(pObjectAX, pObjectAY);
			var objectB:IGridObject = take(pObjectBX, pObjectBY);
			
			add(pObjectAX, pObjectAY, objectB);
			add(pObjectBX, pObjectBY, objectA);
			
			updateIndexes();
		};
		
		public function updateIndexes():void {};
		
		public function clean():void {
			_sizeX = 0;
			_sizeY = 0;
		};
		
		public function clone():IGridContainer {
			var grid:Grid = _pool.get(Grid) as Grid;
			
			if (!grid) {
				grid = new Grid();
				_pool.allocate(Grid, 1);
			}
			
			for (var i:uint = 0; i < sizeX; i++) {
				for (var j:uint = 0; j < sizeY; j++) {
					if (take(i, j)) {
						grid.add(i, j, take(i, j).clone());
					}
				}
			}
			
			return grid;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
		};
		
		private function takeCols(pX:uint):Dictionary {
			var cols:Dictionary = _rows[pX];
			
			if (!cols) {
				cols = new Dictionary();
				_rows[pX] = cols;
			}
			
			if (pX >= _sizeX) {
				_sizeX = pX + 1;
			}
			
			return cols;
		};
	}
}