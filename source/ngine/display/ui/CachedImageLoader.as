package ngine.display.ui {
    import feathers.controls.ImageLoader;

    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    import ngine.files.FilesLoader;

    import ngine.files.Library;
    import ngine.files.TFile;
    import ngine.storage.LocalStorage;

    import starling.events.Event;
    import starling.textures.Texture;

    public class CachedImageLoader extends ImageLoader {
        private static var _library:Library      = Library.getInstance();
        private static var _storage:LocalStorage = LocalStorage.getInstance();

        public function CachedImageLoader() {
            super();
        };

        override public function set source(pValue:Object):void {
            if (pValue is String) {
                var url:String = pValue as String;

                if (_library.contains(url)) {
                    pValue = _library.get(url).content;
                } else if (_storage.load(url)) {
                    var bmp:Object    = _storage.load(url);
                    var bd:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0x0);
                        bd.setPixels(new Rectangle(0, 0, bmp.width, bmp.height), bmp.source);

                    pValue = Texture.fromBitmapData(bd);
                } else {
                    var loader:FilesLoader = new FilesLoader();
                        loader.addEventListener(Event.COMPLETE, loaderCompleteEventHandler);
                        loader.add(url, url);
                        loader.load();
                }
            }

            super.source = pValue;
        };

        private function loaderCompleteEventHandler(pEvent:Event):void {
            var loader:FilesLoader = pEvent.target as FilesLoader;
                loader.removeEventListeners();

            for each (var file:TFile in loader.stack) {
                var bd:BitmapData = file.raw as BitmapData;

                var bmp:Object = {};

                    bmp.source = bd.getPixels(new Rectangle(0, 0, bd.width, bd.height));

                    bmp.width = bd.width;
                    bmp.height = bd.height;

                _storage.save(file.id, bmp);
            }
        };
    };
}
