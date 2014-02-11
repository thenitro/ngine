package ngine.statemachine {
	public interface IState {
		function get id():String;
		
		function start(pArgs:Array = null):void;
		function stop():void;
	}
}