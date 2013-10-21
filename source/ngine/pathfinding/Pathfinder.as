package ngine.pathfinding {
	import ngine.collections.grid.Grid;
	
	public final class Pathfinder {
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
			_pathgrid   = new Grid(pX, pY);
			_pathfinder = new AStar();
			
			for (var i:uint = 0; i < pX; i++) {
				for (var j:uint = 0; j < pY; j++) {
					var node:Node     = new Node();
						node.walkable = true;
						
					_pathgrid.add(i, j, node);
				}
			}
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
	};
}