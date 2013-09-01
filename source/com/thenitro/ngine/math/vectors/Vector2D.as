package com.thenitro.ngine.math.vectors {
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
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
		
		public function lenght():Number {
			return Math.sqrt(lengthSquared());
		};
		
		public function lengthSquared():Number {
			return (_x * _x) + (_y *_y);
		};
		
		public function normalize():void {
			var l:Number = 1 / lenght();
			
			x *= l;
			y *= l;
		};
		
		public function toAngle():Number {
			return Math.atan2(_y, _x);
		};
		
		public function fromAngle(pValue:Number, pLength:Number = 1):void {
			_x = Math.cos(pValue) * pLength;
			_y = Math.sin(pValue) * pLength;
		};
		
		public function zero():void {
			x = 0;
			y = 0;
		};
		
		public function poolPrepare():void {
			zero();
		};
		
		public function dispose():void {
			zero();
		};
	}
}