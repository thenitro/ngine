package ngine.core.collider.parameters {
	import ngine.core.collider.abstract.IColliderParameters;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class LinearColliderParameters implements IColliderParameters, IReusable {
		private static var _pool:Pool = Pool.getInstance();
		private var _method:Function;
		
		public function LinearColliderParameters() {
		};
		
		public static function get NEW():LinearColliderParameters {
			var results:LinearColliderParameters = 
				_pool.get(LinearColliderParameters) as LinearColliderParameters;
			
			if (!results) {
				results = new LinearColliderParameters();
				_pool.allocate(LinearColliderParameters, 1);
			}
			
			return results;
		};
		
		public function get reflection():Class {
			return LinearColliderParameters;
		};
		
		public function get colliderMethod():Function {
			return _method;
		};
		
		public function init(pFunction:Function):void {
			_method = pFunction;
		};
		
		public function poolPrepare():void {
			_method = null;
		};
		
		public function dispose():void {
			_method = null;
		};
	}
}