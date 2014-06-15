package ngine.display {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import starling.core.Starling;

    public class DocumentClass extends Sprite {
		private var TargetClass:Class;
		private var _starling:Starling;
		
		public function DocumentClass(pTargetClass:Class) {
			TargetClass = pTargetClass;
			
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};
		
		private function addedToStageEventHandler(pEvent:Event):void {
			stage.align     = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			_starling = new Starling(TargetClass, stage/*, null, null, 
												Context3DRenderMode.AUTO, 
												Context3DProfile.BASELINE_CONSTRAINED*/);
			_starling.start();
			_starling.simulateMultitouch  = true;
			_starling.enableErrorChecking = true;
			
			CONFIG::DEBUG {
				_starling.showStats = true;
			}
			
			stage.addEventListener(Event.RESIZE, stageResizeEventHandler);
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