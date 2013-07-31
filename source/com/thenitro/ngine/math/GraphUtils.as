package com.thenitro.ngine.math {
	import com.thenitro.ngine.grid.interfaces.IGridContainer;
	import com.thenitro.ngine.grid.interfaces.IGridObject;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

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
				
				neighbors.push( 
					pGrid.take(current.indexX - 1, current.indexY    ),
					pGrid.take(current.indexX    , current.indexY - 1),
					pGrid.take(current.indexX + 1, current.indexY    ),
					pGrid.take(current.indexX    , current.indexY + 1));
				
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
	};
}