package ngine.display.ui {
    import feathers.controls.TextInput;
    import feathers.events.FeathersEventType;

    import starling.events.Event;

    public class RestorableTextInput extends TextInput {
        private var _defaultText:String;

        public function RestorableTextInput() {
            super();
            addEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
        };

        public function set defaultText(pValue:String):void {
            _defaultText = pValue;
        };

        public function get defaultText():String {
            return _defaultText;
        };

        private function addedToStageEventHandler(pEvent:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);

            addEventListener(FeathersEventType.FOCUS_IN,  focusInEventHandler);
            addEventListener(FeathersEventType.FOCUS_OUT, focusOutEventHandler);
        };

        private function focusInEventHandler(pEvent:Event):void {
            if (text == defaultText) {
                text = '';
            }
        };

        private function focusOutEventHandler(pEvent:Event):void {
            if (text == '') {
                text = defaultText;
            }
        };
    }
}
