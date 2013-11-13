package ngine.math.vectors {
	import ngine.math.Random;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class Vector2D implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _x:Number;
		private var _y:Number;
		
		public function Vector2D(pX:Number = 0, pY:Number = 0) {
			_x = pX;
			_y = pY;
		};
		
		public static function get ZERO():Vector2D {
			var result:Vector2D = _pool.get(Vector2D) as Vector2D;
			
			if (!result) {
				_pool.allocate(Vector2D, 1);
				result = new Vector2D();
			}
			
			return result;
		};
		
		public static function distanceSquared(pVectorA:Vector2D, pVectorB:Vector2D):Number {
			var dx:Number = pVectorB.x - pVectorA.x;
			var dy:Number = pVectorB.y - pVectorA.y;
			
			return dx * dx + dy * dy;  
		};
		
		public static function distance(pVectorA:Vector2D, pVectorB:Vector2D):Number {
			return Math.sqrt(distanceSquared(pVectorA, pVectorB));
		};
		
		public static function equals(pVectorA:Vector2D, pVectorB:Vector2D):Boolean {
			return pVectorA.x == pVectorB.x && pVectorA.y == pVectorB.y;
		};
		
		public function get reflection():Class {
			return Vector2D;
		};
		
		public function get x():Number {
			return _x;
		};
		
		public function set x(pValue:Number):void {
			_x = pValue;
		};
		
		public function get y():Number {
			return _y;
		};
		
		public function set y(pValue:Number):void {
			_y = pValue;
		};
		
		public function length():Number {
			return Math.sqrt(lengthSquared());
		};
		
		public function lengthSquared():Number {
			return (_x * _x) + (_y *_y);
		};
		
		public function substract(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x -= pTarget.x;
				result.y -= pTarget.y;
			
			return result;
		};
		
		public function substractScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x -= pTarget;
				result.y -= pTarget;
			
			return result;
		};
		
		public function add(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x += pTarget.x;
				result.y += pTarget.y;
			
			return result;
		};
		
		public function addScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x += pTarget;
				result.y += pTarget;
			
			return result;
		};
		
		public function multiply(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x *= pTarget.x;
				result.y *= pTarget.y;
			
			return result;
		};
		
		public function multiplyScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x *= pTarget;
				result.y *= pTarget;
			
			return result;
		};
		
		public function divide(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x /= pTarget.x;
				result.y /= pTarget.y;
			
			return result;
		};
		
		public function divideScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x /= pTarget;
				result.y /= pTarget;
			
			return result;
		};
		
		public function normalize():void {
			var l:Number = length();
			
			if (l > 0) {
				l = 1 / l;
			}
			
			_x *= l;
			_y *= l;
		};
		
		public function inverse():void {
			_x *= -1;
			_y *= -1;
		};
		
		public function toAngle():Number {
			return Math.atan2(_y, _x);
		};
		
		public function fromAngle(pValue:Number, pLength:Number = 1):void {
			_x = Math.cos(pValue) * pLength;
			_y = Math.sin(pValue) * pLength;
		};
		
		public function angle():Number {
			return Math.atan2(_y, _x);
		};
		
		public function dotProduct(pTarget:Vector2D):Number {
			return x * pTarget.x + y * pTarget.y;
		};
		
		public function crossProduct(pTarget:Vector2D):Number {
			return x * pTarget.y - y * pTarget.x;
		};
		
		public function randomize(pMin:Number, pMax:Number):void {
			x = Random.range(pMin, pMax);
			y = Random.range(pMin, pMax);
		};
		
		public function equals(pVectorB:Vector2D):Boolean {
			return x == pVectorB.x && y == pVectorB.y;
		};
		
		public function zero():void {
			x = 0;
			y = 0;
		};
		
		public function clone():Vector2D {
			var result:Vector2D = Vector2D.ZERO;
			
				result.x = _x;
				result.y = _y;
				
			return result;
		};
		
		public function poolPrepare():void {
			zero();
		};
		
		public function dispose():void {
			zero();
		};
		
		public function toString():String {
			return "[object Vector2D: x=" + x + ", y= " + y + " ]";
		};
	}
}