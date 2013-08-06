package com.thenitro.ngine.statemachine {
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public final class StateMachine extends EventDispatcher {
		public static const STATE_CHANGE:String = 'state_change';
		
		private var _canvas:Sprite;
		
		private var _states:Dictionary;
		
		private var _currState:State;
		private var _prevState:State;
		
		public function StateMachine() {
			_states = new Dictionary();
			
			super();
		};
		
		public function get prevState():State {
			return _prevState;
		};
		
		public function get currentState():State {
			return _currState;
		};
		
		public function setCanvas(pCanvas:Sprite):void {
			_canvas = pCanvas;
		};
		
		public function addState(pState:State):void {
			_states[pState.id] = pState;
		};
		
		public function startState(pStateID:String):void {
			if (_currState) {
				_prevState = _currState;
				_prevState.stop();
				
				_canvas.removeChild(_prevState);
			}
			
			if (!_states[pStateID]) {
				return;
			}
			
			dispatchEventWith(STATE_CHANGE);
			
			_currState = _states[pStateID];
			_currState.addEventListener(Event.ADDED_TO_STAGE,
										addedToStageEventHandler);
			
			_canvas.addChild(_currState);
		};
		
		private function addedToStageEventHandler(pEvent:Event):void {
			_currState.removeEventListener(Event.ADDED_TO_STAGE,
										   addedToStageEventHandler);
			_currState.start();	
		};
	};
}