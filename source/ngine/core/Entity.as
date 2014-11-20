package ngine.core {
    import nmath.TRectangle;
    import nmath.vectors.Vector2D;

    import npooling.IReusable;
    import npooling.Pool;

    import starling.display.DisplayObject;

    public class Entity implements IReusable {
		protected static var _pool:Pool = Pool.getInstance();
		
		protected var _canvas:DisplayObject;
		
		protected var _velocity:Vector2D;
		protected var _position:Vector2D;

		protected var _orientation:Number;
		protected var _size:Number;
		
		protected var _expired:Boolean;
		
		protected var _collider:Entity;

        private var _disposed:Boolean;
		
		public function Entity() {
			_position = Vector2D.ZERO;
			_velocity = Vector2D.ZERO;
			
			_orientation = 0;
		};
		
		public function get reflection():Class {
			return Entity;
		};

        public function get disposed():Boolean {
            return _disposed;
        };
		
		public function get canvas():DisplayObject {
			return _canvas;
		};
		
		public function get position():Vector2D {
			return _position;
		};
		
		public function get velocity():Vector2D {
			return _velocity;
		};
		
		public function set orientation(pValue:Number):void {
			_orientation = pValue;
		};
		
		public function get orientation():Number {
			return _orientation;
		};
		
		public function set size(pValue:Number):void {
			_size = pValue;
		};
		
		public function get size():Number {
			return _size;
		};
		
		public function get expired():Boolean {
			return _expired;
		};
		
		public function get collider():Entity {			
			return _collider;
		};
		
		public function update(pElapsed:Number):void {
			_position.x += _velocity.x * pElapsed;
			_position.y += _velocity.y * pElapsed;
			
			if (_canvas) {
				_canvas.x = _position.x;
				_canvas.y = _position.y;
				
				_canvas.rotation = _orientation;
			}
		};
		
		public function handleCollision(pTarget:Entity):void {
			_collider = pTarget;
			
			expire();
		};
		
		public function expire():void {
			_expired = true;
		};
		
		public function poolPrepare():void {
			_position.zero();
			_velocity.zero();
			
			_orientation = 0;
			_canvas.rotation = 0;
			
			_expired = false;

            if (_canvas) {
                _canvas.removeFromParent();
            }
		};
		
		public function dispose():void {
            _disposed = true;

			_pool.put(_position);
			_pool.put(_velocity);
			
			_position = null;
			_velocity = null;
			
			if (_canvas) {
                _canvas.removeFromParent(true);
				_canvas = null;	
			}
		};
		
		protected function bound(pLevelBounds:TRectangle):void {
			if (!pLevelBounds.isPointInside(_position)) {
				_expired = true;
			}
		};
	}
}