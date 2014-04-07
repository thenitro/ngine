package ngine.core.collider.parameters {
	import ngine.core.collider.abstract.IColliderParameters;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class GridColliderParameters implements IReusable, IColliderParameters {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _colliderMethod:Function;
		
		private var _width:Number;
		private var _height:Number;
		
		private var _gridSize:Number;
		
		public function GridColliderParameters() {
		};
		
		public static function get NEW():GridColliderParameters {
			var results:GridColliderParameters = 
				_pool.get(GridColliderParameters) as GridColliderParameters;
			
			if (!results) {
				results = new GridColliderParameters();
				_pool.allocate(GridColliderParameters, 1);
			}
			
			return results;
		};
		
		public function get reflection():Class {
			return GridColliderParameters;
		};
		
		public function get colliderMethod():Function {
			return _colliderMethod;
		};
		
		public function get width():Number {
			return _width;
		};
		
		public function get height():Number {
			return _height;
		};
		
		public function get gridSize():Number {
			return _gridSize;
		};
		
		public function init(pColliderMethod:Function,
							 pWidth:Number, pHeight:Number,
							 pGridSize:Number):void {
			_colliderMethod = pColliderMethod;
			
			_width  = pWidth;
			_height = pHeight;
			
			_gridSize = pGridSize;
		};
		
		public function poolPrepare():void {
			_colliderMethod = null;
		};
		
		public function dispose():void {
			_colliderMethod = null;
		};
		
	}
}