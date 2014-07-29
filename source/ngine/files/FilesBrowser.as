package ngine.files {
    import flash.events.Event;
    import flash.net.FileReference;
    import flash.net.FileReferenceList;
    import flash.utils.ByteArray;

    import npooling.IReusable;

    import starling.events.EventDispatcher;

    public final class FilesBrowser extends EventDispatcher implements IReusable {
        public static const FILES_LOADED:String = 'loadFiles';
        public static const FILES_SAVED:String  = 'filesSaved';

        private var _disposed:Boolean;

        private var _fileReferenfeList:FileReferenceList;
        private var _filesLoaded:uint;

        private var _files:Vector.<ByteArray>;

        public function FilesBrowser() {
            _disposed = false;

            _fileReferenfeList = new FileReferenceList();
            _files             = new Vector.<ByteArray>();
        };

        public function get reflection():Class {
            return FilesBrowser;
        };

        public function get disposed():Boolean {
            return _disposed;
        };

        public function get files():Array {
            return _fileReferenfeList.fileList;
        };

        public function browseOpen(pTypeFilter:Array):void {
            _filesLoaded  = 0;
            _files.length = 0;

            _fileReferenfeList.browse(pTypeFilter);
            _fileReferenfeList.addEventListener(Event.SELECT, filesSelectedEventHandler)
        };

        public function browseSave(pData:ByteArray, pName:String):void {
            var fileReference:FileReference = new FileReference();
                fileReference.save(pData, pName);
                fileReference.addEventListener(Event.COMPLETE, fileSavedCompletedEventHandler);
        };

        public function poolPrepare():void {
            _files.length = 0;
            _filesLoaded  = 0;
        };

        public function dispose():void {
            _disposed = true;

            _fileReferenfeList = null;
            _files             = null;
        };

        private function filesSelectedEventHandler(pEvent:Event):void {
            for each (var fileRefence:FileReference in _fileReferenfeList.fileList) {
                fileRefence.addEventListener(Event.COMPLETE, currentFileCompleteEventHandler);
                fileRefence.load();
            }
        };

        private function currentFileCompleteEventHandler(pEvent:Event):void {
            _filesLoaded++;

            trace('FilesBrowser.currentFileCompleteEventHandler:', _filesLoaded);

            if (_filesLoaded == _fileReferenfeList.fileList.length) {
                dispatchEventWith(FILES_LOADED);
            }
        };

        private function fileSavedCompletedEventHandler(pEvent:Event):void {
            dispatchEventWith(FILES_SAVED);
        };
    }
}
