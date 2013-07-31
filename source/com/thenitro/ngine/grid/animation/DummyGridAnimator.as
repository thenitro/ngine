package com.thenitro.ngine.grid.animation {
	public class DummyGridAnimator extends GridAnimator {
		
		public function DummyGridAnimator() {
			super();
		};
		
		override public function start(pCompleteEvent:String):void {
			dispatchEventWith(pCompleteEvent);
		};
	};
}