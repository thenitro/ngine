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
			throw new IllegalOperationError('Must be overriden!');
			return null;
		};
		
		public function get machine():StateMachine {
			return _machine;
		};
		
		public function start():void {			
			throw new IllegalOperationError('Must be overriden!');
		};
		
		public function stop():void {
			throw new IllegalOperationError('Must be overriden!');			
		};
	};
}