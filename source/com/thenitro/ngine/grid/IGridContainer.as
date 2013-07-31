package com.thenitro.ngine.grid {
	import com.thenitro.ngine.pool.IReusable;

	public interface IGridContainer extends IReusable {
		function get sizeX():uint;
		function get sizeY():uint;
		
		function add(pX:uint, pY:uint, pObject:IGridObject):IGridObject;
		function take(pX:uint, pY:uint):IGridObject;
		
		function addVisual(pObject:IGridObject):void;
		function removeVisual(pObject:IGridObject):void;
	
		function remove(pX:uint, pY:uint):void;
		
		function update():void;
		
		function swap(pObjectAX:uint, pObjectAY:uint, 
					  pObjectBX:uint, pObjectBY:uint):void;
		
		function clone():IGridContainer;
		function updateIndexes():void;
	};
}