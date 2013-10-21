package ngine.collections.grid.interfaces {
	import ngine.display.gridcontainer.interfaces.IGridContainer;
	
	public interface IGridRenderer {
		function get numChildren():int;
		function generate(pGrid:IGridContainer, pOffsetX:int, pOffsetY:int):void;
	}
}