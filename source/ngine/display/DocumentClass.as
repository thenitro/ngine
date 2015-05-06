package ngine.display {
	CONFIG::MOBILE {
		import flash.desktop.NativeApplication;
	}

	import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import starling.core.Starling;
	import starling.events.Event;

	public class DocumentClass extends Sprite {
		private static const RECTANGLE_HELPER:Rectangle = new Rectangle();

		private var TargetClass:Class;
		private var _starling:Starling;
		
		public function DocumentClass(pTargetClass:Class) {
			TargetClass = pTargetClass;
			
			super();
			addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};
		
		private function addedToStageEventHandler(pEvent:flash.events.Event):void {
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStageEventHandler);

			stage.align     = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = false;
			
			_starling = new Starling(TargetClass, stage);
			_starling.addEventListener(starling.events.Event.CONTEXT3D_CREATE,
									   context3DCreatedEventHandler);
		};

		private function context3DCreatedEventHandler(pEvent:starling.events.Event):void {
			_starling.removeEventListener(starling.events.Event.CONTEXT3D_CREATE,
										  context3DCreatedEventHandler);

			_starling.simulateMultitouch  = true;
			_starling.enableErrorChecking = true;

			_starling.start();

			CONFIG::DEBUG {
				_starling.showStats = true;
				_starling.showStatsAt('right');
			}

			stage.addEventListener(flash.events.Event.RESIZE, stageResizeEventHandler);

			CONFIG::MOBILE {
				NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE,
						nativeApplicationActivateEventHandler);

				NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE,
						nativeApplicationDeactivateEventHandler);
			}
		};

		private function stageResizeEventHandler(pEvent:flash.events.Event):void {
			RECTANGLE_HELPER.x = 0;
			RECTANGLE_HELPER.y = 0;

			RECTANGLE_HELPER.width = stage.stageWidth;
			RECTANGLE_HELPER.height = stage.stageHeight;

			_starling.viewPort = RECTANGLE_HELPER;

			_starling.stage.stageWidth  = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
		};

		CONFIG::MOBILE {
			private function nativeApplicationActivateEventHandler(pEvent:flash.events.Event):void {
				_starling.start();
			};

			private function nativeApplicationDeactivateEventHandler(pEvent:flash.events.Event):void {
				_starling.stop();
			};
		}
	};
}