package com.thenitro.ngine.grid.interfaces {
	
	public interface IGridRenderer {
		function get numChildren():int;
		function generate(pGrid:IGridContainer, pOffsetX:int, pOffsetY:int):void;
	}
}