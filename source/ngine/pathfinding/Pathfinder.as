package ngine.pathfinding {
	import ndatas.grid.Grid;
	
	public final class Pathfinder {
		private static const X:uint = 0;
		private static const Y:uint = 0;
		
		private static var _allowInstance:Boolean;
		private static var _instance:Pathfinder;
		
		private var _pathgrid:Grid;
		private var _pathfinder:AStar;
		
		public function Pathfinder() {
			if (!_allowInstance) {
				throw new Error("Pathfinder: class is singleton! " +
					"Use Pathfinder.getInstance() " +
					"instead of using 'new' keyword!");
			}
		};
		
		public static function getInstance():Pathfinder {
			if (!_instance) {
				_allowInstance = true;
				_instance      = new Pathfinder();
				_allowInstance = false;
			}
			
			return _instance;
		};
		
		public function init(pX:uint, pY:uint):void {
			_pathgrid   = new Grid();
			_pathfinder = new AStar();
			
			for (var i:uint = 0; i < pX; i++) {
				for (var j:uint = 0; j < pY; j++) {
					var node:Node     = new Node();
						node.walkable = true;
						
					_pathgrid.add(i, j, node);
				}
			}
		};
		
		public function isWalkable(pIndexX:uint, pIndexY:uint):Boolean {
			var node:Node = _pathgrid.take(pIndexX, pIndexY) as Node;
			
			if (!node) {
				return false;
			}
			
			return node.walkable;
		};
		
		public function setWalkable(pIndexX:uint, pIndexY:uint):void {
			var node:Node     = _pathgrid.take(pIndexX, pIndexY) as Node;			
				node.walkable = true;
		};
		
		public function setUnWalkable(pIndexX:uint, pIndexY:uint):void {
			var node:Node     = _pathgrid.take(pIndexX, pIndexY) as Node;
				node.walkable = false;
		};
		
		public function findPath(pStartX:uint, pStartY:uint, 
								 pEndX:uint, pEndY:uint, 
								 pHeuristic:Function = null):Vector.<Node> {
			_pathfinder.findPath(_pathgrid, pHeuristic, 
								 _pathgrid.take(pStartX, pStartY) as Node, 
								 _pathgrid.take(pEndX, pEndY) as Node);
			return _pathfinder.path;
		};
		
		public function reducePath(pTarget:Vector.<Node>):Vector.<Node> {
			var result:Vector.<Node> = new Vector.<Node>();
			
			var currentSameValue:uint;
			var lastSameValue:uint;
			
			var startNode:Node;
			var node:Node;
			var nextNode:Node;
			
			startNode = node = pTarget.shift();
			
			while (pTarget.length) {
				nextNode = pTarget.shift();
				
				if (node.indexX == nextNode.indexX) {
					currentSameValue = X;
				} else {
					currentSameValue = Y;
				}
				
				if (currentSameValue != lastSameValue) {
					if (node != startNode) result.push(node);
				}
				
				node = nextNode;
				lastSameValue = currentSameValue;
			}
			
			result.push(node);
			
			return result;
		};
	};
}