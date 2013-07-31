package com.thenitro.ngine.grid {
	
	public interface IGridGenerator {
		function setWaveDepth(pSize:uint):void;
		function setPlayerSkill(pSkill:Number):void;
		function setMultiplier(pValue:Number):void;
		function generateGrid(pGrid:IGridContainer, pElements:Vector.<Class>, 
						  	  pEndX:uint, pEndY:uint, 
							  pCellWidth:Number, pCellHeight:Number):void;
		function generateOne(pI:uint, pJ:uint, pGrid:IGridContainer, 
							 pElements:Vector.<Class>, 
							 pCellWidth:Number, pCellHeight:Number):IGridObject;
	}
}