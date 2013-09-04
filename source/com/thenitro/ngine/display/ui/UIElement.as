package com.thenitro.ngine.display.ui {
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
	import starling.display.Sprite;
	
	public class UIElement extends Sprite implements IReusable {
		protected static var _pool:Pool = Pool.getInstance();
		
		public function UIElement() {
			super();
		};
		
		public function get reflection():Class {
			return UIElement;
		};
		
		override public function dispose():void {
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