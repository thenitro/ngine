package ngine.display {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	public class DocumentClass extends Sprite {
		private var _starling:Starling;
		
		public function DocumentClass(pTargetClass:Class, pDebug:Boolean) {
			super();
			
			stage.align     = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addEventListener(Event.RESIZE, stageResizeEventHandler);
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			_starling = new Starling(pTargetClass, stage);
			_starling.start();
			_starling.simulateMultitouch  = true;
			_starling.enableErrorChecking = true;
			
			if (pDebug) {
				_starling.showStats = true;
			}
		};
		
		private function stageResizeEventHandler(pEvent:Event):void {
			_starling.viewPort = new Rectangle(0, 0, 
											   stage.stageWidth, 
											   stage.stageHeight);
			
			_starling.stage.stageWidth  = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
		};
	};
}