package ngine {
    import ngine.core.Entity;

    import nmath.TRectangle;

    import starling.display.DisplayObject;

    public final class FollowCamera {
		private var _target:Entity;
		
		private var _bounds:TRectangle;
		
		private var _canvas:DisplayObject;
		
		private var _screenWidth:Number;
		private var _screenHeight:Number;
		
		private var _offset:Number;
		
		public function FollowCamera() {
		};
		
		public function setTarget(pTarget:Entity):void {
			_target = pTarget;
		};
		
		public function init(pCanvas:DisplayObject, pBounds:TRectangle,
							 pScreenWidth:Number, pScreenHeight:Number, 
							 pOffset:Number):void {
			_canvas = pCanvas;
			
			_bounds = pBounds;
			
			_screenWidth  = pScreenWidth;
			_screenHeight = pScreenHeight;
			
			_offset = pOffset;
		};
		
		public function update():void {
			if (!_target || !_canvas) {
				return;
			}
			
			var topLeftX:Number = _target.position.x - _screenWidth  / 2;
			var topLeftY:Number = _target.position.y - _screenHeight / 2;
			
			topLeftX = Math.max(0, topLeftX);
			topLeftY = Math.max(0, topLeftY);
			
			topLeftX = Math.min(_bounds.size.x - _screenWidth  - _offset, topLeftX);
			topLeftY = Math.min(_bounds.size.y - _screenHeight - _offset, topLeftY);
			
			_canvas.x = -topLeftX;
			_canvas.y = -topLeftY;
		};
	};
}