package com.thenitro.ngine.math {
	import flash.errors.IllegalOperationError;
	
	public final class Random {
		
		public function Random() {
			throw new IllegalOperationError("Random is static!");
		};
		
		public static function range(pMin:Number, pMax:Number):Number {
			return pMin + (Math.random() * (pMax - pMin)); 
		};
	}
}