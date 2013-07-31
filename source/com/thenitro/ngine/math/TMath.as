package com.thenitro.ngine.math {
	import flash.errors.IllegalOperationError;

	public final class TMath {
		
		public function TMath() {
			throw new IllegalOperationError("Math is static!");
		};
		
		public static function roundDecimal(pValue:Number, pPrecision:int):Number {
			var decimal:Number = Math.pow(10, pPrecision);
			
			return Math.round(decimal * pValue) / decimal;
		};
	};
}