package ngine.display.gridcontainer.interfaces {
	import ndatas.MatrixMxN;
	import ndatas.grid.IGridObject;
	
	import npooling.IReusable;

	public interface IGridContainer extends IReusable {
		function get sizeX():uint;
		function get sizeY():uint;
		
		function get cellWidth():Number;
		function get cellHeight():Number;
		
		function get count():uint;
		
		function add(pX:uint, pY:uint, pObject:Object):Object;
		function take(pX:uint, pY:uint):Object;
		
		function addVisual(pObject:Object, pUpdatePosition:Boolean = true):void;
		function removeVisual(pObject:Object):void;
	
		function remove(pX:uint, pY:uint):void;
		
		function update():void;
		
		function swap(pObjectAX:uint, pObjectAY:uint, 
					  pObjectBX:uint, pObjectBY:uint):void;
		
		function clone():MatrixMxN;
		function updateIndexes():void;
	};
}