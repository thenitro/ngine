package ngine.files {
    public interface IProgressable {
        function get description():String;

        function get progress():Number;

        function get progressed():int;
        function get total():int;
    }
}
