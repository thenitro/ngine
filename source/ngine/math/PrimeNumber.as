package ngine.math {
	import flash.errors.IllegalOperationError;

	public final class PrimeNumber {
		
		public function PrimeNumber() {
			throw new IllegalOperationError("PrimeNumber is static!");
		};
		
		/**
		 * Method checking is pValue Prime Numer in O(N) time
		 * http://en.wikipedia.org/wiki/Prime_number
		 * 
		 * @param pValue int (integer) value to calculate
		 * @return Boolean is pValue Prime
		 * 
		 */		
		public static function isPrime(pValue:int):Boolean {
			if (pValue < 2) {
				return false;
			}
			
			for (var i:int = 2; i <= Math.sqrt(pValue); i++) {
				if (pValue % i == 0) {
					return false;
				}
			}
			
			return true;
		};
		
		/**
		 * Method checking is int Prime Number in O(log N)
		 * http://en.wikipedia.org/wiki/Prime_number
		 * with Fermat primality test
		 * http://en.wikipedia.org/wiki/Fermat_primality_test  
		 * 
		 * @param pValue int (integer) value to calculate
		 * @return Boolean is pValue Prime
		 * 
		 */		
		
		public static function isPrimeByFerma(pValue:int):Boolean {
			if (pValue < 2) {
				return false;
			}
			
			if (pValue == 2) {
				return true;
			}
			
			for (var i:int = 0; i < 100; i++) {
				var a:int = (Math.random() % (pValue - 2)) + 2;
				
				if (TMath.gcd(a, pValue) != 1) {
					return false;
				}
				
				if (TMath.pows(a, pValue - 1, pValue) != 1) { 
					return false;
				}
			}
			
			return true;
		};
	};
}