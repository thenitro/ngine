package ngine.math.vectors {
	import ngine.pool.IReusable;
	import ngine.pool.Pool;
	
	import flash.geom.Vector3D;
	
	public class TVector3D implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function TVector3D(pX:Number=0.0, pY:Number=0.0, pZ:Number=0.0) {
			_x = pX;
			_y = pY;
			_z = pZ;
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
		
		public function get z():Number {
			return _z;
		};
		
		public function set z(pValue:Number):void {
			_z = pValue;
		};		
		
		public static function get ZERO():TVector3D {
			var result:TVector3D = _pool.get(TVector3D) as TVector3D;
			
			if (!result) {
				_pool.allocate(TVector3D, 1);
				result = new TVector3D();
			}
			
			return result;
		};
		
		public static function distance(pVectorA:TVector3D, 
										pVectorB:TVector3D):Number {
			return Math.sqrt(distanceSquared(pVectorA, pVectorB));
		};
		
		public static function distanceSquared(pVectorA:TVector3D, 
											   pVectorB:TVector3D):Number {
			var dx:Number = pVectorB.x - pVectorA.x;
			var dy:Number = pVectorB.y - pVectorA.y;
			var dz:Number = pVectorB.z - pVectorA.z;
			
			return dx * dx + dy * dy + dz * dz;
		};
		
		public function get reflection():Class {
			return TVector3D;
		};
		
		public function length():Number {
			return Math.sqrt(lengthSquared());
		};
		
		public function lengthSquared():Number {
			return (_x * _x) + (_y * _y) + (_z * _z);
		};
		
		public function reverse(pNewInstance:Boolean = false):TVector3D {
			return multiplyScalar(-1, pNewInstance);
		};
		
		public function add(pVectorB:TVector3D, 
							pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
				
				result.x += pVectorB.x;
				result.y += pVectorB.y;
				result.z += pVectorB.z;
				
			return result;
		};
		
		public function addScalar(pScalar:Number, 
								  pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x += pScalar;
				result.y += pScalar;
				result.z += pScalar;
				
			return result;
		};
		
		public function substract(pVectorB:TVector3D, 
								 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x -= pVectorB.x;
				result.y -= pVectorB.y;
				result.z -= pVectorB.z;
			
			return result;
		};
		
		public function substactScalar(pScalar:Number,
								 	   pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x -= pScalar;
				result.y -= pScalar;
				result.z -= pScalar;
			
			return result;
		};
		
		public function multiply(pVectorB:TVector3D, 
								 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x *= pVectorB.x;
				result.y *= pVectorB.y;
				result.z *= pVectorB.z;
			
			return result;
		};
		
		public function multiplyScalar(pScalar:Number, 
									   pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x *= pScalar;
				result.y *= pScalar;
				result.z *= pScalar;
			
			return result;
		};
		
		public function divide(pVectorB:TVector3D, 
								 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x /= pVectorB.x;
				result.y /= pVectorB.y;
				result.z /= pVectorB.z;
			
			return result;
		};
		
		public function divideScalar(pScalar:Number, 
									 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x /= pScalar;
				result.y /= pScalar;
				result.z /= pScalar;
			
			return result;
		};
		
		public function clone():TVector3D {
			var result:TVector3D = ZERO;
			
				result.x = x;
				result.y = y;
				result.z = z;
			
			return result;
		};
		
		public function zero():void {
			x = 0;
			y = 0;
			z = 0;
		};
		
		public function poolPrepare():void {
			zero();
		};
		
		public function dispose():void {
			zero();
		};
	}
}