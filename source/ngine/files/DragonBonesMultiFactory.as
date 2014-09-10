package ngine.files {
    import dragonBones.factorys.StarlingFactory;

    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import starling.events.Event;
    import starling.events.EventDispatcher;
    import starling.textures.TextureSmoothing;

    public class DragonBonesMultiFactory extends EventDispatcher implements IProgressable {
        public static const PROGRESS:String = 'dragon_bones_multi_factory_progress';

        private var _files:Vector.<TFile>;
        private var _factories:Vector.<StarlingFactory>;

        private var _map:Dictionary;

        public function DragonBonesMultiFactory() {
            super();

            _files     = new Vector.<TFile>();
            _factories = new Vector.<StarlingFactory>();

            _map = new Dictionary();
        };

        public function get description():String {
            return 'Parsing animation';
        };

        public function get progress():Number {
            return progressed / total;
        };

        public function get progressed():int {
            return total - _factories.length;
        };

        public function get total():int {
            return _files.length;
        };

        public function addFile(pFile:TFile):void {
            _files.push(pFile);
        };

        public function load():void {
            for each (var file:TFile in _files) {
                if (file.content is StarlingFactory) {
                    parsingComplete(file.content as StarlingFactory);
                    continue;
                }

                var factory:StarlingFactory = new StarlingFactory();
                    factory.generateMipMaps = true;
                    factory.addEventListener(Event.COMPLETE,
                                             factoryParsingCompleteEventHandler);
                    factory.parseData(file.content as ByteArray, file.id);

                _map[factory] = file;
            }
        };

        private function factoryParsingCompleteEventHandler(pEvent:Object):void {
            var target:StarlingFactory  = pEvent.target as StarlingFactory;
                target.displaySmoothing = TextureSmoothing.TRILINEAR;

            var file:TFile = _map[target];
                file.setContent(target, file.bytes);

            parsingComplete(target);
        };

        private function parsingComplete(pTarget:StarlingFactory):void {
            _factories.splice(_factories.indexOf(pTarget), 1);

            dispatchEventWith(PROGRESS);

            if (!_factories.length) {
                _files.length = 0;

                dispatchEventWith(Event.COMPLETE);
            }
        };
    };
}
