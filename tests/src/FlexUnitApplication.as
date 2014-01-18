package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexUnitTests.ngine.math.MathSuite;
	import flexUnitTests.ngine.math.PrimeNumberCase;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			testRunner.portNumber=8765; 
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "NgineTests");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(flexUnitTests.ngine.math.MathSuite);
			testsToRun.push(flexUnitTests.ngine.math.PrimeNumberCase);
			return testsToRun;
		}
	}
}