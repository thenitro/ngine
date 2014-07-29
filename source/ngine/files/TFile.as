package ngine.files {
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    import npooling.IReusable;

    public class TFile implements IReusable {
        private var _url:String;
        private var _id:String;

        private var _extension: String;

        private var _bytes:uint;

        private var _content:*;

        private var _disposed:Boolean;

        public function TFile(pURL:String, pID:String) {
            _url = pURL;
            _id = pID;

            _extension =  pURL.substr(pURL.length -3, pURL.length);
        };

        public function setContent(pValue:Object, pBytesLoded:int):void {
            _content = pValue;
            _bytes   = (pBytesLoded < 0) ? _bytes : uint(pBytesLoded);
        };

        public function get url():String {
            return _url;
        };

        public function get id():String {
            return _id;
        };

        public function get extension():String {
            return _extension;
        };

        public function get content():Object{
            return _content;
        };

        public function get bytes():uint {
            return _bytes;
        };

        public function get disposed():Boolean {
            return _disposed;
        };

        public function get reflection():Class {
            return TFile;
        };

        public function setID(pID:String):void {
            _id = pID;
        };

        public function toString():String {
            return '[ File (id: ' + this.id + ', url: ' + this.url + ') ]';
        };

        public function poolPrepare():void {
            clear();

            _bytes    = 0;
            _disposed = false;
        };

        public function dispose(): void {
            _disposed = true;

            clear();
        };

        private function clear():void {
            _url = null;
            _id  = null;

            _extension = null;

            if (_content is BitmapData) {
                (_content as BitmapData).dispose();
            } else if (_content is ByteArray) {
                (_content as ByteArray).clear();
            }

            _content = null;
        };
    };
}