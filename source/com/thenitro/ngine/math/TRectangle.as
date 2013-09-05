package com.thenitro.ngine.math {
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
	public final class TRectangle implements IReusable {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _position:Vector2D;
		private var _size:Vector2D;
		
		public function TRectangle() {
			_position = Vector2D.ZERO;
			_size     = Vector2D.ZERO;
		};
		
		public function get reflection():Class {
			return TRectangle;
		};
		
		public function get position():Vector2D {
			return _position;
		};
		
		public function get size():Vector2D {
			return _size;
		};
		
		public function isPointInside(pPosition:Vector2D):Boolean {
			if (pPosition.x < _position.x || pPosition.y < _position.y ||
				pPosition.x > _size.x || pPosition.y > _size.y) {
				return false;
			}
			
			return true;
		};
		
		public function poolPrepare():void {
			_position.zero();
			_size.zero();
		};
		
		public function dispose():void {
			_pool.put(_position);
			_pool.put(_size);
			
			_position = null;
			_size     = null;
		};
	}
}