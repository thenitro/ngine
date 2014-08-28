package ngine.files {
    import dragonBones.factorys.StarlingFactory;

    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import starling.events.Event;
    import starling.events.EventDispatcher;
    import starling.textures.TextureSmoothing;

    public class DragonBonesMultiFactory extends EventDispatcher {
        private var _files:Vector.<TFile>;
        private var _factories:Vector.<StarlingFactory>;

        private var _map:Dictionary;

        public function DragonBonesMultiFactory() {
            super();

            _files     = new Vector.<TFile>();
            _factories = new Vector.<StarlingFactory>();

            _map = new Dictionary();
        };

        public function addFile(pFile:TFile):void {
            _files.push(pFile);
        };

        public function load():void {
            for each (var file:TFile in _files) {
                var factory:StarlingFactory = new StarlingFactory();
                    factory.generateMipMaps = true;
                    factory.addEventListener(Event.COMPLETE,
                                             factoryParsingCompleteEventHandler);
                    factory.parseData(file.content as ByteArray, file.id);

                _map[factory] = file;
            }

            _files.length = 0;
        };

        private function factoryParsingCompleteEventHandler(pEvent:Object):void {
            var target:StarlingFactory = pEvent.target as StarlingFactory;
                target.displaySmoothing = TextureSmoothing.TRILINEAR;
            var file:TFile             = _map[target];

            _factories.splice(_factories.indexOf(target), 1);

            file.setContent(target, file.bytes);

            if (!_factories.length) {
                dispatchEventWith(Event.COMPLETE);
            }
        };
    };
}
