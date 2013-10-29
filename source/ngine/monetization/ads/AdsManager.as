package ngine.monetization.ads {
	import com.hdi.nativeExtensions.NativeAds;
	import com.hdi.nativeExtensions.NativeAdsEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Stage;
	import starling.events.EventDispatcher;
	
	public final class AdsManager extends EventDispatcher {
		public static const AD_CLICKED:String = 'ad_clicked';
		public static const AD_SHOWED:String  = 'ad_showed';
		public static const AD_ERROR:String   = 'ad_error';
		
		private static var _allowInstance:Boolean;
		private static var _instance:AdsManager;
		
		private var _timeOut:int;
		private var _timer:Timer;
		
		private var _inited:Boolean;
		private var _showing:Boolean;
		
		public function AdsManager() {
			super();
			
			if (!_allowInstance) {
				throw new Error("AdsManager is Singleton!");
			}
		};
		
		public static function getInstance():AdsManager {
			if (!_instance) {
				_allowInstance = true;
				_instance      = new AdsManager();
				_allowInstance = false;
			}
			
			return _instance;
		};
		
		public function init(pID:String):void {
			if (NativeAds.isSupported) {
				NativeAds.setUnitId(pID);
				
				CONFIG::DEBUG {
					NativeAds.setAdMode(false);
				}
				
				CONFIG::RELEASE {
					NativeAds.setAdMode(true);	
				}
				
				NativeAds.initAd(0, 0, 480, 75);
				NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_CLICKED,
													  globalClickedEventHandler);
				
				_inited = true;
			}
		};
		
		public function showAd(pStage:Stage, pTimeOut:int = -1):void {
			if (!_inited || _showing) {
				return;
			}
			
			if (!pStage) {
				return;
			}
			
			_timeOut = pTimeOut;
			
			NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_RECEIVED,
												  adReceivedEventHandler);
			NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_CLICKED,
												  adClickedEventHandler);
			NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_ERROR,
												  adErrorEventHandler);
			NativeAds.showAd((pStage.stageWidth - 480) / 2, 0, 480, 75);
			
			_showing = true;
		};
		
		public function hideAd():void {
			if (!_showing) {
				return;
			}
			
			NativeAds.hideAd();
			
			removeTimer();
			removeAdListeners();
			
			_showing = false;
		};
		
		private function adReceivedEventHandler(pEvent:NativeAdsEvent):void {
			NativeAds.dispatcher.removeEventListener(NativeAdsEvent.AD_RECEIVED,
												     adReceivedEventHandler);
			
			dispatchEventWith(AD_SHOWED);
			
			if (_timeOut <= 0) {
				return;
			}
			
			_timer = new Timer(_timeOut, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, 
									timerCompleteEventHandler);
			_timer.start();
		};
		
		private function timerCompleteEventHandler(pEvent:TimerEvent):void {
			hideAd();
		};
		
		private function adClickedEventHandler(pEvent:NativeAdsEvent):void {
			NativeAds.dispatcher.removeEventListener(NativeAdsEvent.AD_CLICKED,
												  	 adClickedEventHandler);
			
			hideAd();
		};
		
		private function adErrorEventHandler(pEvent:NativeAdsEvent):void {
			dispatchEventWith(AD_ERROR);
			hideAd();
		};
		
		private function removeTimer():void {
			if (!_timer) {
				return;
			}
			
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, 
									   timerCompleteEventHandler);
			_timer = null;
		};
		
		private function removeAdListeners():void {
			NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_RECEIVED,
												  adReceivedEventHandler);
			NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_CLICKED,
												  adClickedEventHandler);
			NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_ERROR,
												  adErrorEventHandler);
		};
		
		private function globalClickedEventHandler(pEvent:NativeAdsEvent):void {
			dispatchEventWith(AD_CLICKED);
		};
	}
}