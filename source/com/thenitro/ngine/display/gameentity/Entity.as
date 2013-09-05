package com.thenitro.ngine.display.gameentity {
	import com.thenitro.ngine.math.TRectangle;
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
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
		
		public function Entity() {
			_position = Vector2D.ZERO;
			_velocity = Vector2D.ZERO;
			
			_orientation = 0;
		};
		
		public function get reflection():Class {
			return Entity;
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
		
		public function get orientation():Number {
			return _orientation;
		};
		
		public function get radius():Number {
			return _size;
		};
		
		public function get expired():Boolean {
			return _expired;
		};
		
		public function get collider():Entity {			
			return _collider;
		};
		
		public function update():void {
			_position.x += _velocity.x;
			_position.y += _velocity.y;
			
			_canvas.x = _position.x;
			_canvas.y = _position.y;
			
			_canvas.rotation = _orientation;
		};
		
		public function handleCollision(pTarget:Entity):void {
			_collider = pTarget;
			_expired  = true;
		};
		
		public function poolPrepare():void {
			_position.zero();
			_velocity.zero();
			
			_orientation = 0;
			
			_expired = false;
		};
		
		public function dispose():void {
			_pool.put(_position);
			_pool.put(_velocity);
			
			_position = null;
			_velocity = null;
			
			if (_canvas) {
				_canvas.dispose();
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