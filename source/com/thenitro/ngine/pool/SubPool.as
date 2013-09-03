package com.thenitro.ngine.pool {
	internal final class SubPool {
		public var maxSize:uint;
		
		private var _elements:Vector.<IReusable>;
		
		public function SubPool() {
			maxSize = 0;
			
			_elements = new Vector.<IReusable>();
		};
		
		public function get size():uint {
			return _elements.length;
		};
			
		public function inPool(pElement:IReusable):Boolean {
			return _elements.indexOf(pElement) != -1;
		};
		
		public function put(pElement:IReusable):void {			
			pElement.poolPrepare();
			
			_elements.push(pElement);
		};
		
		public function get():IReusable {
			return _elements.pop();
		};
		
		public function disposeInstances():void {
			for each (var element:IReusable in _elements) {
				element.dispose();
				element = null;
			}
			
			_elements.length = 0;
		};
	};
}