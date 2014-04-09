package ngine.net {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import starling.events.EventDispatcher;
	
	public class XMLLoader extends EventDispatcher {
		
		public function XMLLoader() {
			super();
		};
		
		public function load(pFileURL:String):void {
			var request:URLRequest = new URLRequest(pFileURL);	
				request.method     = URLRequestMethod.GET;
				
			var loader:URLLoader = new URLLoader();
				loader.addEventListener(flash.events.Event.COMPLETE, 
										loaderCompleteEventHandler);
				
				loader.addEventListener(IOErrorEvent.IO_ERROR, 
										ioErrorEventHandler);
				
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
										securityErrorEventHandler);
				
				loader.load(request);
		};
		
		protected function parse(pXML:XML):void {
			
		};
		
		protected function getLocal():Class {
			return null;
		};

        protected function loadLocal():void {
            var CurrentClass:Class = getLocal();
            var ba:ByteArray = new CurrentClass() as ByteArray;
            var str:String   = ba.readUTFBytes(ba.length);

            parse(new XML(str));
        };

        protected function loadingComplete(pData:String):void {
            parse(new XML(pData));
        };
		
		protected function parseComplete():void {
			dispatchEventWith(starling.events.Event.COMPLETE);
		};
		
		private function loaderCompleteEventHandler(pEvent:flash.events.Event):void {
			trace("XMLLoader.loaderCompleteEventHandler(pEvent)");
			
			var loader:URLLoader = pEvent.target as URLLoader;
				loader.removeEventListener(flash.events.Event.COMPLETE, loaderCompleteEventHandler);
			
			loadingComplete(loader.data as String);
		};
		
		private function ioErrorEventHandler(pEvent:flash.events.Event):void {
			trace("XMLLoader.ioErrorEventHandler(pEvent)");
			loadLocal();
		};
		
		private function securityErrorEventHandler(pEvent:SecurityErrorEvent):void {
			trace("XMLLoader.securityErrorEventHandler(pEvent)");
			loadLocal();
		};

	};
}