package ngine.display.gridcontainer.interfaces {
	import ngine.pool.IReusable;
	import ndatas.grid.IGridObject;

	public interface IGridContainer extends IReusable {
		function get sizeX():uint;
		function get sizeY():uint;
		
		function get cellWidth():uint;
		function get cellHeight():uint;
		
		function get count():uint;
		
		function add(pX:uint, pY:uint, pObject:IGridObject):IGridObject;
		function take(pX:uint, pY:uint):IGridObject;
		
		function addVisual(pObject:IGridObject, pUpdatePosition:Boolean = true):void;
		function removeVisual(pObject:IGridObject):void;
	
		function remove(pX:uint, pY:uint):void;
		
		function update():void;
		
		function swap(pObjectAX:uint, pObjectAY:uint, 
					  pObjectBX:uint, pObjectBY:uint):void;
		
		function clone():IGridContainer;
		function updateIndexes():void;
	};
}