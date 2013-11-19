package ngine.pathfinding {
	import ndatas.grid.IGridObject;
	
	public final class Node implements IGridObject {
		public var g:Number;
		public var f:Number;
		public var h:Number;
		
		public var parent:Node;
		
		private var _indexX:uint;
		private var _indexY:uint;
		
		private var _walkable:Boolean;
		
		public function Node() {
			
		};
		
		public function get indexX():uint {
			return _indexX;
		};
		
		public function get indexY():uint {
			return _indexY;
		};
		
		public function get reflection():Class {
			return Node;
		};
		
		public function set walkable(pValue:Boolean):void {
			_walkable = pValue;
		};
		
		public function get walkable():Boolean {
			return _walkable;
		};
		
		public function updateIndex(pX:uint, pY:uint):void {
			_indexX = pX;
			_indexY = pY;
		};
		
		public function clone():IGridObject {
			return null;
		};
		
		public function poolPrepare():void {
		};
		
		public function dispose():void {
		};
	}
}