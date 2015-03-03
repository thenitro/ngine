package ngine.localization {
    import flash.utils.Dictionary;

    internal class Language {
        private var _id:String;
        private var _data:Dictionary;

        public function Language(pID:String) {
            _id = pID;
            _data = new Dictionary();
        };

        public function get id():String {
            return _id;
        };

        public function getField(pKey:String):String {
            return _data[pKey];
        };

        public function addField(pKey:String, pField:String):void {
            _data[pKey] = pField;
        };
    }
}
