package ngine.statemachine {
	import flash.errors.IllegalOperationError;
	
	import starling.display.Sprite;
	
	public class State extends Sprite implements IState {
		private var _machine:StateMachine;
		
		public function State(pMachine:StateMachine) {
			_machine = pMachine;
			
			super();
		};
		
		public function get id():String {
			throw new IllegalOperationError(this + ': Must be overriden!');
			return null;
		};
		
		public function get machine():StateMachine {
			return _machine;
		};
		
		public function start(pArgs:Array = null):void {
		};
		
		public function stop():void {
		};
	};
}