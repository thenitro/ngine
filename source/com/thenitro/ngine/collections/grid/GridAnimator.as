package com.thenitro.ngine.collections.grid {	
	import flash.utils.Dictionary;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	
	public final class GridAnimator extends EventDispatcher {
		private var _animating:Boolean;
		private var _completeEvent:String;
		
		private var _addedCount:uint;
		private var _animatedCount:uint;
		
		private var _objects:Dictionary;
		
		private var _tweens:Vector.<Tween>;
		
		public function GridAnimator() {
			_tweens     = new Vector.<Tween>();
			_objects    = new Dictionary();
			_addedCount = 0;
			
			super();
		};
		
		public function add(pElement:IGridObject, pX:Number, pY:Number, pTime:Number):void {
			if (_animating) {
				trace("Error: GridAnimator.add: Already animating");
				return;
			}
			
			if (!pElement) {
				return;
			}
			
			if (!_objects[pElement]) {
				_addedCount++;	
			} else {
				_tweens.splice(_tweens.indexOf(_objects[pElement]), 1);
			}
			
			var tween:Tween          = new Tween(pElement, pTime);
				tween.onCompleteArgs = [ pElement ];
				tween.onComplete     = tweenCompleteEventHandler;
				tween.moveTo(pX, pY);
				
			_tweens.push(tween);
			_objects[pElement] = tween;
		};
		
		public function remove(pElement:IGridObject):void {
			if (_objects[pElement]) {
				_addedCount--;
				_tweens.splice(_tweens.indexOf(_objects[pElement]), 1);
				
				delete _objects[pElement];
			}
		};
		
		public function start(pCompleteEvent:String):void {
			if (_animating) {
				trace("Error: GridAnimator.start: Already animating");
				return;
			}
			
			_completeEvent = pCompleteEvent;
			
			if (!Starling.juggler || !_addedCount) {
				complete();
				return;
			}
			
			_animating     = true;
			_animatedCount = 0;
			
			for each (var tween:Tween in _tweens) {
				Starling.juggler.add(tween);
			}
		};
		
		public function clean():void {
			_animating = false;
			
			_addedCount    = 0;
			_animatedCount = 0;
			
			_tweens.length = 0;
			
			for (var object:Object in _objects) {
				delete _objects[object];
			}
		};
		
		private function tweenCompleteEventHandler(pElement:IGridObject):void {
			delete _objects[pElement];
			
			_animatedCount++;
			
			if (_animatedCount >= _addedCount) {
				_addedCount = 0;
				_animating  = false;
				
				_tweens.length = 0;
				
				complete();
			}
		};
		
		private function complete():void {
			if (_completeEvent) {
				dispatchEventWith(_completeEvent);
			}
		};
	};
}