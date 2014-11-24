package {
    import flash.display.Sprite;
    import flash.display.Stage;

    import ngine.tests.HexagonalGridTests;

    import org.flexunit.internals.TraceListener;
    import org.flexunit.runner.FlexUnitCore;

    public class Main extends Sprite {
        private var _testCore:FlexUnitCore;

        public static var currentStage:Stage;

        public function Main() {
            currentStage = stage;

            _testCore = new FlexUnitCore();
            _testCore.addListener(new TraceListener());

            _testCore.run(HexagonalGridTests);
        };
    }
}
