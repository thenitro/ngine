package ngine.files {

    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;

    import starling.events.EventDispatcher;
    import starling.textures.Texture;

    public class FilesLoader extends EventDispatcher {
        public static const PROGRESS_EVENT:String = 'event_progress';

        private var _urlRequest:URLRequest;

        private var _stack:Dictionary;
        private var _instances:Dictionary;
        private var _loaders:Dictionary;

        private var _library:Library;

        private var _bytesLoaded:Number;
        private var _bytesTotal:Number;

        private var _completed:Boolean;

        private var _total:uint;
        private var _loaded:uint;

        public function FilesLoader() {
            _urlRequest = new URLRequest();

            _stack     = new Dictionary();
            _instances = new Dictionary();
            _loaders   = new Dictionary();

            _library  = Library.getInstance();

            _completed = true;
        };

        public function get completed():Boolean {
            return _completed;
        };

        public function get loaded():uint {
            return _loaded;
        };

        public function get total():uint {
            return _total;
        };

        public function get stack():Dictionary {
            return _stack;
        };

        public function get queueLenght():Number {
            return _total - _loaded;
        };

        public function add(pURL:String, pID:String, pForceBinaryLoading:Boolean = false):void {
            if (!_completed) {
                trace('FilesLoader.add: Wait till files loading!');
                return;
            }

            if (_stack[pURL]) {
                return;
            }

            if (_library.getByID(pID) || _library.getByURL(pURL)) {
                return;
            }

            _stack[pURL] = new TFile(pURL, pID, pForceBinaryLoading);
            _total++;
        };

        public function load():void {
            _completed = false;
            _loaded    = 0;

            if (!_total) {
                filesLoaded();
            }

            for each (var file:TFile in _stack) {
                loadFile(file);
            }
        };

        private function loadFile(pFile:TFile):void{
            _urlRequest.url = pFile.url;

            var loaderContext:LoaderContext = new LoaderContext();
                loaderContext.checkPolicyFile = true;

            if ((pFile.extension == 'jpg' || pFile.extension == 'png' ||
                 pFile.extension == 'gif' || pFile.extension == 'swf') &&
                    !pFile.forceBinaryLoading) {

                var loader:Loader = new Loader();
                    loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
                                                              loaderIOErrorHandler);
                    loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
                                                              loaderCompleteEventHandler);
                    loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,
                                                              loaderProgressEventHandler);
                    loader.load(_urlRequest, loaderContext);

                _loaders[loader.contentLoaderInfo] = loader;
                _instances[loader]                 = pFile;

                if (pFile.extension == 'swf') {
                    loaderContext.applicationDomain = ApplicationDomain.currentDomain;
                    loaderContext.checkPolicyFile   = false;
                }
            } else {
                var urlLoader:URLLoader = new URLLoader();

                if (pFile.extension == "xml" && !pFile.forceBinaryLoading) {
                    urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
                } else {
                    urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
                }

                urlLoader.addEventListener(IOErrorEvent.IO_ERROR,
                                           urlLoaderIOErrorHandler);
                urlLoader.addEventListener(Event.COMPLETE,
                                           urlLoaderCompleteHandler);
                urlLoader.addEventListener(ProgressEvent.PROGRESS,
                                           urlLoaderProgressEventHandler);
                urlLoader.load(_urlRequest);

                _instances[urlLoader] = pFile;
            }
        };

        private function loaderCompleteEventHandler(pEvent:Event):void {
            var target:LoaderInfo = pEvent.target as LoaderInfo;
            var loader:Loader     = _loaders[target] as Loader;

            if (!loader) {
                return;
            }

            target.removeEventListener(Event.COMPLETE,
                    loaderCompleteEventHandler);
            target.removeEventListener(IOErrorEvent.IO_ERROR,
                    loaderIOErrorHandler);
            target.removeEventListener(ProgressEvent.PROGRESS,
                    loaderProgressEventHandler);

            var file:TFile = _instances[loader] as TFile;

            if (loader.content is MovieClip) {
                file.setContent(loader, target.bytesTotal);
            } else {
                file.setContent(Texture.fromBitmapData(Bitmap(loader.content).bitmapData.clone()),
                                target.bytesTotal);

                loader.unload();
            }

            _library.addFile(file);

            fileLoaded();
        };

        private function urlLoaderCompleteHandler(pEvent:Event):void {
            var target:URLLoader = pEvent.target as URLLoader;
                target.removeEventListener(Event.COMPLETE,
                                           urlLoaderCompleteHandler);
                target.removeEventListener(IOErrorEvent.IO_ERROR,
                                           urlLoaderIOErrorHandler);
                target.removeEventListener(ProgressEvent.PROGRESS,
                                           urlLoaderProgressEventHandler);

            var file:TFile = _instances[target] as TFile;
                file.setContent(target.data, target.bytesTotal);

            _library.addFile(file);

            fileLoaded();
        };

        private function loaderProgressEventHandler(pEvent:ProgressEvent):void {
            _bytesLoaded = pEvent.bytesLoaded;
            _bytesTotal  = pEvent.bytesTotal;

            dispatchEventWith(PROGRESS_EVENT);
        };

        private function urlLoaderProgressEventHandler(pEvent: ProgressEvent): void{
            _bytesLoaded = pEvent.bytesLoaded;
            _bytesTotal  = pEvent.bytesTotal;

            dispatchEventWith(PROGRESS_EVENT);
        };

        private function urlLoaderIOErrorHandler(pEvent:IOErrorEvent):void {
            trace('FilesLoader.urlLoaderIOErrorHandler: ' + pEvent.text);
        };

        private function loaderIOErrorHandler(pEvent:IOErrorEvent):void {
            var file:TFile = _instances[pEvent.target] as TFile;

            if (file) {
                trace('FilesLoader.loaderIOErrorHandler: cannot load ' + file.id);
            }
        };

        private function fileLoaded():void {
            _loaded++;

            if (_loaded >= _total) {
                filesLoaded();
            }

            dispatchEventWith(PROGRESS_EVENT);
        };

        private function filesLoaded():void {
            var id:Object;

            for (id in _stack) {
                delete _stack[id];
            }

            for (id in _loaders) {
                delete _loaders[id];
            }

            for (id in _instances) {
                delete _instances[id];
            }

            _completed = true;
            _total     = 0;

            dispatchEventWith(Event.COMPLETE);
        };
    };
}