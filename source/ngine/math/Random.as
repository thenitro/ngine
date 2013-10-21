package ngine.math {
	import flash.errors.IllegalOperationError;
	
	public final class Random {
		
		public function Random() {
			throw new IllegalOperationError("Random is static!");
		};
		
		public static function range(pMin:Number, pMax:Number):Number {
			return pMin + (Math.random() * (pMax - pMin)); 
		};
		
		public static function probability(pPercents:Number):Boolean {
			return range(0, 100) < pPercents;
		};
		
		public static function variation(pValue:Number, pVariation:Number):Number {
			return pValue + 2.0 * (Math.random() - 0.5) * pVariation;
		};
		
		public static function get color():uint {
			return Math.random() * 0xFFFFFF;
		};
	}
}