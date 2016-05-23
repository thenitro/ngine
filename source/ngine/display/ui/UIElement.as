package ngine.display.ui {
	import npooling.IReusable;
	import npooling.Pool;

	import starling.display.Sprite;

	public class UIElement extends Sprite implements IReusable {
		protected static var _pool:Pool = Pool.getInstance();

		private var _disposed:Boolean;

		public function UIElement() {
			super();
		};
		
		public function get reflection():Class {
			return UIElement;
		};

		public function get disposed():Boolean {
		    return _disposed;
		};
		
		override public function dispose():void {
			_disposed = true;

			super.dispose();
			clean();
		};
		
		public function draw():void {
			
		};
		
		public function clean():void {
			
		};
		
		public function poolPrepare():void {
			clean();
		};
	};
}