package com.thenitro.ngine.math {
	import com.thenitro.ngine.grid.IGridContainer;
	import com.thenitro.ngine.grid.IGridObject;
	
	import flash.errors.IllegalOperationError;

	public class GraphUtils {
		private static const EMPTY_ARRAY:Array = [];
		
		public function GraphUtils() {
			throw new IllegalOperationError('GraphUtils is static!');
		};
		
		public static function bfs(pIndexX:uint, pIndexY:uint, pGrid:IGridContainer):Array {
			var current:IGridObject;
			var searched:IGridObject = pGrid.take(pIndexX, pIndexY);
			
			if (!searched) {
				return EMPTY_ARRAY;
			}
			
			var neighbors:Array;
			
			var seen:Array     = EMPTY_ARRAY.concat();
			var selected:Array = EMPTY_ARRAY.concat();
			var queue:Array    = EMPTY_ARRAY.concat();
				queue.push(searched);
			
			while (queue.length) {
				current   = queue.shift();
				
				if (!current) {
					continue;
				}
				
				neighbors = [ 
					pGrid.take(current.indexX - 1, current.indexY    ),
					pGrid.take(current.indexX    , current.indexY - 1),
					pGrid.take(current.indexX + 1, current.indexY    ),
					pGrid.take(current.indexX    , current.indexY + 1) ];
				
				for each (var neighbor:IGridObject in neighbors) {
					if (!neighbor) {
						continue;
					}
					
					if (seen.indexOf(neighbor) != -1) {
						continue;
					}
					
					seen.push(neighbor);
					
					if (neighbor.reflection == searched.reflection) {
						selected.push(neighbor);
						queue.push(neighbor);
					} else {
						continue;
					}	
				}
			}
			
			return selected;
		};
	};
}