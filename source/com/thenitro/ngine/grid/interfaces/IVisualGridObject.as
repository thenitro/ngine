package com.thenitro.ngine.grid.interfaces {
	
	public interface IVisualGridObject extends IGridObject {
		function set alpha(pValue:Number):void;
		function get alpha():Number;
		
		function get x():Number;
		function get y():Number;
		
		function set x(pValue:Number):void;
		function set y(pValue:Number):void;
	}
}