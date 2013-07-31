package com.thenitro.ngine.grid {
	
	public interface IGridRenderer {
		function get numChildren():int;
		function generate(pGrid:IGridContainer, pOffsetX:int, pOffsetY:int):void;
	}
}