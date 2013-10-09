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
		
		public static function map(pNumber:Number, 
								   pMinValue:Number, pMaxValue:Number,
								   pTargetMin:Number, pTargetMax:Number):Number {
			var index:Number = (pMaxValue - pMinValue) / pNumber;
			
			return (pTargetMax - pTargetMin) / index; 
		};
		
		public static function lerp(pA:Number, pB:Number, pT:Number):Number {
			return pA + (pB - pA) * pT;
		};
		
		public static function valueInRange(pValue:Number, 
											 pMin:Number, pMax:Number):Boolean {
			return pValue >= pMin && pValue <= pMax;
		};
	};
}