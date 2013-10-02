package com.thenitro.ngine.math {
	import com.thenitro.ngine.grid.Grid;
	import com.thenitro.ngine.grid.interfaces.IGridContainer;
	import com.thenitro.ngine.grid.interfaces.IGridObject;
	
	import feathers.controls.Header;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	public class GraphUtils {
		private static const EMPTY_ARRAY:Array = [];
		
		public function GraphUtils() {
			throw new IllegalOperationError('GraphUtils is static!');
		};
		
		public static function bfs(pIndexX:uint, pIndexY:uint,
								   pGrid:IGridContainer, pAddHeighbors:Function):Array {
			var current:IGridObject;
			var searched:IGridObject = pGrid.take(pIndexX, pIndexY);
			
			if (!searched) {
				return EMPTY_ARRAY;
			}
			
			var neighbors:Array = [];
			
			var seen:Dictionary = new Dictionary();
			var selected:Array = EMPTY_ARRAY.concat();
			var queue:Array    = EMPTY_ARRAY.concat();
				queue.push(searched);
			
			while (queue.length) {
				current = queue.shift();
				
				if (!current) {
					continue;
				}
				
				pAddHeighbors(pGrid, current.indexX, current.indexY, neighbors);
				
				for each (var neighbor:IGridObject in neighbors) {
					if (!neighbor) {
						continue;
					}
					
					if (seen[neighbor]) {
						continue;
					}
					
					seen[neighbor] = true;
					
					if (neighbor.reflection == searched.reflection) {
						selected.push(neighbor);
						queue.push(neighbor);
					} else {
						continue;
					}	
				}
				
				neighbors.length = 0;
			}
			
			return selected;
		};
		
		public static function addNeighborsHorizontal(pGrid:Grid, 
													  pIndexX:int, pIndexY:int, 
													  pContainer:Array):void {
			pContainer.push(pGrid.take(pIndexX - 1, pIndexY), pGrid.take(pIndexX + 1, pIndexY));
		};
		
		public static function addNeighborsVertical(pGrid:Grid, 
													pIndexX:int, pIndexY:int, 
													pContainer:Array):void {
			pContainer.push(pGrid.take(pIndexX, pIndexY - 1), pGrid.take(pIndexX, pIndexY + 1));
		};
		
		public static function addNeighborsVerticalHorizintal(pGrid:Grid, 
													pIndexX:int, pIndexY:int, 
													pContainer:Array):void {
			addNeighborsVertical(pGrid, pIndexX, pIndexY, pContainer);
			addNeighborsHorizontal(pGrid, pIndexX, pIndexY, pContainer);
		};
	};
}