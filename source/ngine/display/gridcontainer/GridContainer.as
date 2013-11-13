package ngine.display.gridcontainer {
	import ndatas.grid.Grid;
	import ndatas.grid.IGridObject;
	import ngine.display.gridcontainer.interfaces.IGridContainer;
	import ngine.display.gridcontainer.interfaces.IVisualGridObject;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class GridContainer extends Grid implements IGridContainer {
		private var _container:Sprite;
		
		public function GridContainer(pCellWidth:uint = 0, pCellHeight:uint = 0) {
			_container = new Sprite();
			
			super(pCellWidth, pCellHeight);
		};
		
		public function get canvas():Sprite {
			return _container;
		};
		
		override public function addVisual(pObject:IGridObject, pUpdatePosition:Boolean = true):void {
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
		
		override public function removeVisual(pObject:IGridObject):void {
			_container.removeChild(pObject as DisplayObject);
		};
		
		override public function update():void {
			for (var i:uint = 0; i < sizeX; i++) {
				for (var j:uint = 0; j < sizeY; j++) {
					addVisual(take(i, j)); 
				}
			}
		};
		
		override public function swap(pObjectAX:uint, pObjectAY:uint, 
									  pObjectBX:uint, pObjectBY:uint):void {
			super.swap(pObjectAX, pObjectAY, pObjectBX, pObjectBY);
			updateIndexes();
		};
		
		override public function updateIndexes():void {
			for (var i:uint = 0; i < sizeX; i++) {
				for (var j:uint = 0; j < sizeY; j++) {
					var data:IGridObject = take(i, j);
					var child:DisplayObject = data as DisplayObject;
					
					if (child && _container.contains(child)) {
						_container.setChildIndex(data as DisplayObject, i + j * sizeX);
					}
				}
			}
		};
		
		override public function clone():IGridContainer {
			var grid:GridContainer = _pool.get(GridContainer) as GridContainer;
			
			if (!grid) {
				grid = new GridContainer();
				_pool.allocate(GridContainer, 1);
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
		
		override public function clean():void {
			for (var i:uint = 0; i < sizeX; i++) {
				for (var j:uint = 0; j < sizeY; j++) {
					if (!take(i, j)) {
						continue;
					}
					
					var child:IGridObject = take(i, j);
					
					_container.removeChild(child as DisplayObject);
					remove(i, j);
					
					_pool.put(child);
				}
			}
			
			super.clean();
		};
	};
}