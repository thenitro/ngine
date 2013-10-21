package ngine.pathfinding {
	import ngine.collections.grid.Grid;
	
	import flash.utils.Dictionary;
	
	public class AStar {
		private var _open:Array;
		
		private var _openNodes:Dictionary;
		private var _closedNodes:Dictionary;
		
		private var _grid:Grid;
		
		private var _startNode:Node;
		private var _endNode:Node;
		
		private var _path:Vector.<Node>;
		
		private var _heuristic:Function;
		
		private static var _straightCost:Number = 1.0;
		private static var _diagonalCost:Number = Math.SQRT2;
		
		public function AStar() {
			_open = [];
			
			_openNodes   = new Dictionary();
			_closedNodes = new Dictionary();
		};
		
		public function get path():Vector.<Node> {
			return _path;
		};
		
		public static function manhattan(pNode:Node, pEndNode:Node):Number {
			return Math.abs(pNode.x - pEndNode.x) * _straightCost + 
			       Math.abs(pNode.y + pEndNode.y) * _straightCost;
		};
		
		public static function euclidian(pNode:Node, pEndNode:Node):Number {
			var dx:Number = pNode.x - pEndNode.x;
			var dy:Number = pNode.y - pEndNode.y;
			
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		};
		
		public static function diagonal(pNode:Node, pEndNode:Node):Number {
			var dx:Number = Math.abs(pNode.x - pEndNode.x);
			var dy:Number = Math.abs(pNode.y - pEndNode.y);
			
			var diagonal:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			
			return _diagonalCost * diagonal + _straightCost * (straight - 2 * diagonal);
		};
		
		public function findPath(pPathGrid:Grid, pHeuristic:Function,
								pStartNode:Node, pEndNode:Node):Boolean {
			if (!pStartNode || !pEndNode) return false;
			
			_grid      = pPathGrid;
			_heuristic = pHeuristic;
			
			_open.length   = 0;
			
			var id:Object;
			
			for (id in _openNodes) {
				delete _openNodes[id];
			}
			
			for (id in _closedNodes) {
				delete _closedNodes[id];
			}
			
			_startNode = pStartNode;
			_endNode   = pEndNode;
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode, _endNode);
			_startNode.f = _startNode.g + _startNode.h;  
			
			return search();
		};
		
		private function search():Boolean {
			var node:Node = _startNode;
			
			var startX:uint;
			var startY:uint;
			
			var endX:uint;
			var endY:uint;
			
			var i:uint;
			var j:uint;
			
			var test:Node;
			
			var cost:Number;
			
			var g:Number;
			var h:Number;
			var f:Number;
			
			var min:Function = Math.min;
			var max:Function = Math.max;
			
			var iterations:uint = 0;
			
			while (node != _endNode) {
				startX = max(0, node.x - 1);
				startY = max(0, node.y - 1);
				
				endX = min(_grid.sizeX - 1, node.x + 1);
				endY = min(_grid.sizeY - 1, node.y + 1);
				
				for (i = startX; i <= endX; ++i) {
					for (j = startY; j <= endY; ++j) {
						test = _grid.take(i, j) as Node;
						
						iterations++;
						
						if (test == node || !test.walkable ||
							!Node(_grid.take(node.x, test.y)).walkable ||
							!Node(_grid.take(test.x, node.y)).walkable) {
								continue;
						}
						
						cost = _straightCost;
						
						if (!((node.x == test.x) || (node.y == test.y))) {
							cost = _diagonalCost; //diagonal
							//continue; //diagonal off
						}
							
						g = node.g + cost;
						h = _heuristic(test, _endNode);
						f = g + h;
						
						if (_openNodes[test] || _closedNodes[test]) {
							if (test.f > f) {
								test.g = g;
								test.h = h;
								test.f = f;
								
								test.parent = node;
							}
						} else {
							test.g = g;
							test.h = h;
							test.f = f;
							
							test.parent = node;
							
							_open.push(test);
							_openNodes[test] = test;
						}
					}
				}
				
				_closedNodes[node] = node;
				
				if (_open.length == 0) {
					//trace('AStart.search: Cannot find path!');
					return false;
				}
				
				_open.sortOn('f', Array.NUMERIC);
				
				node = _open.shift() as Node;
			}
			
			buildPath();
			//trace("AStar.search:", 'FINDED in', iterations, 'iterations');
			
			return true;
		};
		
		private function buildPath():void {
			_path = new Vector.<Node>();
			
			var node:Node = _endNode;
			
			_path.push(node);
			
			while (node != _startNode) {
				node = node.parent;
				
				_path.unshift(node);
			}
		};
	};
}