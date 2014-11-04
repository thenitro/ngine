package ngine.display.gridcontainer.interfaces {
	import ncollections.MatrixMxN;
	
	import npooling.IReusable;

	public interface IGridContainer extends IReusable {
		function get maxX():int;
		function get maxY():int;
		
		function get cellWidth():Number;
		function get cellHeight():Number;
		
		function get count():int;
		
		function add(pX:int, pY:int, pObject:Object):Object;
		function take(pX:int, pY:int):Object;
		
		function addVisual(pObject:Object, pUpdatePosition:Boolean = true):void;
		function removeVisual(pObject:Object):void;
	
		function remove(pX:int, pY:int):void;
		
		function update():void;
		
		function swap(pObjectAX:int, pObjectAY:int, 
					  pObjectBX:int, pObjectBY:int):void;
		
		function clone():MatrixMxN;
		function updateIndexes():void;
	};
}