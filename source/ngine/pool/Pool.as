package ngine.pool {
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	public final class Pool {
		private static var _instance:Pool;
		private static var _allowInstance:Boolean;
		
		private var _classes:Dictionary;
		
		public function Pool() {
			if (!_allowInstance) throw new IllegalOperationError('Pool: use Pool.getInstance() instead of "new" keyword!');
			
			_classes  = new Dictionary(); 
		};
				
		public static function getInstance():Pool {
			if (!_instance) {
				_allowInstance = true;
				_instance      = new Pool();
				_allowInstance = false;
			}
			
			return _instance;
		};
		
		public function allocate(pClass:Class, pSize:uint):void {
			var subPool:SubPool = _classes[pClass] as SubPool;
			
			if (!subPool) {
				_classes[pClass] = subPool = new SubPool();
			}
			
			subPool.maxSize += pSize;
		};
		
		public function put(pElement:IReusable):void {
			if (!pElement) return;
			
			var subPool:SubPool = _classes[pElement.reflection] as SubPool;
			
			if (subPool) {
				if (subPool.inPool(pElement)) {
					trace("Pool.put(pElement) duplicate: " + pElement);					
					return;
				}
				
 				if (subPool.size < subPool.maxSize) {
					subPool.put(pElement);
				} else {
					/*trace('Pool.put: not enough memory for ' 
						+ pElement.reflection + ' ' + pElement + ' max is ' + subPool.maxSize + ' currentSize ' + subPool.size);
					*/
					pElement.dispose();
					pElement = null;
				}
			} else {
				trace('Pool.put: memory not allocated for class ' 
					+ pElement.reflection + ' use Pool.allocate() first!');
				
				pElement.dispose();
			}
		};
		
		public function get(pClass:Class):IReusable {
			var subPool:SubPool = _classes[pClass] as SubPool;
			
			if (subPool) {
				if (subPool.size) {					
					return subPool.get();
				}
			}
			
			return null;
		};
		
		public function disposeClassInstances(pClass:Class):void {
			var subPool:SubPool = _classes[pClass] as SubPool;
			
			if (subPool) {
				subPool.disposeInstances();
			} else {
				trace('Pool.disposeClassInstances: ' + pClass + 
					' not found in pool. Use allocate() method first!');
			}
		};
	};
}