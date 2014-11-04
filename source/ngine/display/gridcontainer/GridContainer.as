package ngine.display.gridcontainer {
	import ncollections.MatrixMxN;
	import ncollections.grid.Grid;
	import ncollections.grid.IGridObject;
	
	import ngine.display.gridcontainer.interfaces.IGridContainer;
	import ngine.display.gridcontainer.interfaces.IVisualGridObject;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class GridContainer extends Grid implements IGridContainer {
		private var _container:Sprite;
		
		private var _cellWidth:Number;
		private var _cellHeight:Number;
		
		public function GridContainer(pCellWidth:int = 0, pCellHeight:int = 0) {
			_container = new Sprite();
			
			_cellWidth  = pCellWidth;
			_cellHeight = pCellHeight;	
			
			super();
		};
		
		override public function get reflection():Class {
			return GridContainer;
		};
		
		public function get canvas():Sprite {
			return _container;
		};
		
		public function get cellWidth():Number {
			return _cellWidth;
		};
		
		public function get cellHeight():Number {
			return _cellHeight;
		};
		
		override public function add(pX:int, pY:int, pObject:Object):Object {
			super.add(pX, pY, pObject);
			addVisual(pObject, false);
			
			return pObject;
		};
		
		override public function remove(pX:int, pY:int):void {
			removeVisual(take(pX, pY));
			super.remove(pX, pY);
		};
		
		override public function swap(pObjectAX:int, pObjectAY:int, 
									  pObjectBX:int, pObjectBY:int):void {
			super.swap(pObjectAX, pObjectAY, pObjectBX, pObjectBY);
			updateIndexes();
		};
		
		override public function clone():MatrixMxN {
			var grid:GridContainer = _pool.get(GridContainer) as GridContainer;
			
			if (!grid) {
				grid = new GridContainer();
				_pool.allocate(GridContainer, 1);
			}
			
			for (var i:int = minX; i < maxX; i++) {
				for (var j:int = minY; j < maxY; j++) {
					if (take(i, j)) {
						grid.add(i, j, take(i, j).clone());
					}
				}
			}
			
			return grid;
		};
		
		override public function clean():void {
			for (var i:int = minX; i < maxX; i++) {
				for (var j:int = minY; j < maxY; j++) {
					if (!take(i, j)) {
						continue;
					}
					
					var child:IGridObject = take(i, j) as IGridObject;
					
					_container.removeChild(child as DisplayObject);
					remove(i, j);
					
					_pool.put(child);
				}
			}
			
			super.clean();
		};
		
		public function addVisual(pObject:Object, pUpdatePosition:Boolean = true):void {
			var object:IVisualGridObject = pObject as IVisualGridObject;
			
			if (!object || !(object is DisplayObject)) {
				return;
			}
			
			if (pUpdatePosition) {
				object.x = object.indexX * cellWidth;
				object.y = object.indexY * cellHeight;
			}
			
			_container.addChild(object as DisplayObject);
			
			updateIndexes();
		};
		
		public function removeVisual(pObject:Object):void {
			_container.removeChild(pObject as DisplayObject);
		};
		
		public function update():void {
			for (var i:int = minX; i < maxX; i++) {
				for (var j:int = minY; j < maxY; j++) {
					addVisual(take(i, j) as IGridObject);
				}
			}
		};
		
		public function updateIndexes():void {
			for (var i:int = minX; i < maxX; i++) {
				for (var j:int = minY; j < maxY; j++) {
					var data:IGridObject = take(i, j) as IGridObject;
					var child:DisplayObject = data as DisplayObject;
					
					if (child && _container.contains(child)) {
						_container.setChildIndex(data as DisplayObject, i + j * maxX);
					}
				}
			}
		};
	};
}