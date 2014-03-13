package ngine.math {
	import flash.errors.IllegalOperationError;

	public final class TMath {
		
		public function TMath() {
			throw new IllegalOperationError("Math is static!");
		};
		
		/**
		 * returns next highest power of two
		 * hack by http://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
		 * 
		 * By Sean Eron Anderson
		 * seander@cs.stanford.edu
		 * 
		 * @param pValue
		 * @return 
		 * 
		 */		
		public static function nextPowerOfTwo(pValue:int):int {
			pValue--;
			
			pValue |= pValue >>  1;
			pValue |= pValue >>  2;
			pValue |= pValue >>  4;
			pValue |= pValue >>  8;
			pValue |= pValue >> 16;
			
			pValue++;
			
			return pValue;
		};
		
		public static function roundDecimal(pValue:Number, 
											pPrecision:int):Number {
			var decimal:Number = Math.pow(10, pPrecision);
			
			return Math.round(decimal * pValue) / decimal;
		};
		
		/**
		 * The clamped value.
		 * if value > max, max will be returned
		 * if value < min, min will be returned
		 * if min <= value >= max, value will be returned
		 *  
		 * @param pValue The value to clamp.
		 * @param pMin   The minimum value. If value is less than min, min will be returned.
		 * @param pMax   The maximum value. If value is greater than max, max will ber returned.
		 * @return       The clamped value.
		 * 
		 */		
		public static function clamp(pValue:Number, 
									 pMin:Number, pMax:Number):Number {
			if (pValue <= pMin) {
				pValue = pMin;
			} else if (pValue >= pMax) {
				pValue = pMax;
			}
			
			return pValue;
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
		
		/**
		 * Calculating Greatest common divisor
		 * http://en.wikipedia.org/wiki/Greatest_common_divisor
		 * with Euclidean algorithm
		 * http://en.wikipedia.org/wiki/Euclidean_algorithm
		 * 
		 * @param pA int
		 * @param pB int
		 * @return int greatest common divisor 
		 * 
		 */		
		
		public static function gcd(pA:int, pB:int):int {
			var temp:int;
			
			while (pB != 0) {
				temp = pB;
				pB   = pA % pB;
				pA   = temp;
			}
			
			return pA;
		};
		
		public static function mul(pA:int, pB:int, pM:int):int {
			if (pB == 1) {
				return pA;
			}
			
			if (pB % 2 == 0) {
				var temp:int = mul(pA, pB / 2, pM);
				
				return (2 * temp) % pM;
			}
			
			return (mul(pA, pB - 1, pM) + pA) % pM;
		};
		
		public static function pows(pA:int, pB:int, pM:int):int {
			if (pB == 0) {
				return 1;
			}
			
			if (pB % 2 == 0) {
				var temp:int = pows(pA, pB / 2, pM);
				return mul(temp, temp, pM) % pM;
			}
			
			return (mul(pows(pA, pB - 1, pM), pA, pM)) % pM;
		};
	};
}