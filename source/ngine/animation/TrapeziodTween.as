package ngine.animation {
    import nmath.vectors.Vector2D;

    import npooling.IReusable;
    import npooling.Pool;

    import starling.animation.IAnimatable;
    import starling.display.DisplayObject;
    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class TrapeziodTween extends EventDispatcher implements IReusable, IAnimatable {
        private static var _pool:Pool = Pool.getInstance();

        private var _disposed:Boolean;

        private var _time:Number;
        private var _timePassed:Number;

        private var _trapezoid:Number;

        private var _target:DisplayObject;

        private var _start:Vector2D;
        private var _destination:Vector2D;

        private var _destinationFunction:Function;

        public function TrapeziodTween() {
            super();

            _timePassed = 0;
            _start      = Vector2D.ZERO;
        };

        public function get reflection():Class {
            return TrapeziodTween;
        };

        public function get disposed():Boolean {
            return _disposed;
        };

        public function init(pTarget:DisplayObject, pTime:Number,
                             pDestination:Object, pTrapezoid:Number):void {
            _time        = pTime;
            _target      = pTarget;

            _destination         = pDestination as Vector2D;
            _destinationFunction = pDestination as Function;

            _start.x = pTarget.x;
            _start.y = pTarget.y;

            _trapezoid = pTrapezoid;
        };

        public function advanceTime(pTime:Number):void {
            if (_timePassed >= _time) {
                dispatchEventWith(Event.REMOVE_FROM_JUGGLER);
                dispatchEventWith(Event.COMPLETE);
                return;
            }

            _timePassed += pTime;

            if (_destinationFunction) {
                //TODO: find destination
            }

            var time:Number   = _timePassed / _time;
            var lerp:Vector2D = Vector2D.lerp(_start, _destination, time);
                lerp.y       += Math.sin(time * Math.PI) * _trapezoid;

            _target.x = lerp.x;
            _target.y = lerp.y;

            _pool.put(lerp);
        };

        public function poolPrepare():void {
            removeEventListeners();

            _timePassed = 0;
            _target     = null;

            _pool.put(_destination);
            _destination = null;

            _destinationFunction = null;
        };

        public function dispose():void {
            removeEventListeners();

            _disposed = true;

            _pool.put(_start);
            _start = null;

            _pool.put(_destination);
            _destination = null;

            _destinationFunction = null;
        };
    }
}
