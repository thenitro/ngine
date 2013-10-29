package ngine.monetization.statistics {
	import com.google.analytics.GATracker;
	
	import flash.display.DisplayObject;
	
	public final class GoogleAnalytics {
		private static var _allowInstance:Boolean;
		private static var _instance:GoogleAnalytics;
		
		private var _inited:Boolean;
		private var _tracker:GATracker;
		
		public function GoogleAnalytics() {
			if (!_allowInstance) {
				throw new Error("GoogleAnalytics is static!");
			}
		};
		
		public static function getInstance():GoogleAnalytics {
			if (!_instance) {
				_allowInstance = true;
				_instance      = new GoogleAnalytics();
				_allowInstance = false;
			}
			
			return _instance;
		};
		
		public function init(pID:String, pDocumentClass:DisplayObject):void {
			_inited  = true;
			
			CONFIG::RELEASE {
				_tracker = new GATracker(pDocumentClass, pID, "AS3", false);
			}
			
			CONFIG::DEBUG {
				_tracker = new GATracker(pDocumentClass, pID, "AS3", true);
			}
		};
		
		public function showPage(pID:String):void {
			if (!_inited) {
				return;
			}
			
			_tracker.trackPageview(pID);
		};
		
		public function fireEvent(pCategory:String, pAction:String, 
								   pData:String, pValue:Number):void {
			if (!_inited) {
				return;
			}
			
			_tracker.trackEvent(pCategory, pAction, pData, pValue);
		};
	};
}