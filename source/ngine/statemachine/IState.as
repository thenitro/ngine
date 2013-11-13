package ngine.statemachine {
	public interface IState {
		function get id():String;
		
		function start():void;
		function stop():void;
	}
}