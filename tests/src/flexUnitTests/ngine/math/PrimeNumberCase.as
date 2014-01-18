package flexUnitTests.ngine.math
{
	import ngine.math.PrimeNumber;
	
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class PrimeNumberCase
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function isPrimeCase():void {
			assertFalse(PrimeNumber.isPrime(0));
			assertFalse(PrimeNumber.isPrime(1));
			assertFalse(PrimeNumber.isPrime(4));
			
			assertTrue(PrimeNumber.isPrime(2));
			assertTrue(PrimeNumber.isPrime(3));
			assertTrue(PrimeNumber.isPrime(5));
			assertTrue(PrimeNumber.isPrime(7));
		};
		
		[Test]
		public function isPrimeByFermaCase():void {
			assertFalse(PrimeNumber.isPrimeByFerma(0));
			assertFalse(PrimeNumber.isPrimeByFerma(1));
			assertFalse(PrimeNumber.isPrimeByFerma(4));
			
			assertTrue(PrimeNumber.isPrimeByFerma(2));
			assertTrue(PrimeNumber.isPrimeByFerma(3));
			assertTrue(PrimeNumber.isPrimeByFerma(5));
			assertTrue(PrimeNumber.isPrimeByFerma(7));
		};
	}
}