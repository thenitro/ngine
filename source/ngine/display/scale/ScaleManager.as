package ngine.display.scale {
    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class ScaleManager extends EventDispatcher {
        private var _scale:Number;
        private var _scaleFactor:Number;

        private var _observers:Vector.<IScalable>;

        public function ScaleManager() {
            _observers = new Vector.<IScalable>();

            _scale       = 1.0;
            _scaleFactor = 1.0;
        };

        public function get scale():Number {
            return _scale;
        };

        public function get scaleFactor():Number {
            return _scaleFactor;
        };

        public function register(pObserver:IScalable):void {
            pObserver.scale(_scale, _scaleFactor);

            _observers.push(pObserver);
        };

        public function setScale(pScale:Number):void {
            _scale       = pScale;
            _scaleFactor = 1 / _scale;

            for each (var observer:IScalable in _observers) {
                observer.scale(_scale, _scaleFactor);
            }

            dispatchEventWith(Event.CHANGE, false, scale);
        };
    };
}
