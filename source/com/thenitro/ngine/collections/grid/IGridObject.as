package com.thenitro.ngine.grid {
	import com.thenitro.ngine.pool.IReusable;
	
	public interface IGridObject extends IReusable {
		function set alpha(pValue:Number):void;
		function get alpha():Number;
		
		function get x():Number;
		function get y():Number;
		
		function set x(pValue:Number):void;
		function set y(pValue:Number):void;
		
		function get indexX():uint;
		function get indexY():uint;
		
		function updateIndex(pX:uint, pY:uint):void;
		
		function clone():IGridObject;
	};
};