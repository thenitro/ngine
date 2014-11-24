package {
    import flash.events.Event;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    public class FlexUnitStarlingIntegration extends Sprite {

        public function FlexUnitStarlingIntegration() {
            super();
            addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageEventHandler);
        };

        private function addedToStageEventHandler(pEvent:starling.events.Event):void {
            Starling.current.nativeStage.dispatchEvent(new flash.events.Event(flash.events.Event.COMPLETE));
        };
    }
}
