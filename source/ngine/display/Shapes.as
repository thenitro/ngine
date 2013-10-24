package ngine.display {
	import starling.display.Graphics;
	
	public final class Shapes {
		
		public function Shapes() {
			
		};
		
		public static function drawStar(pTarget:Graphics, 
										pX:Number, pY:Number, 
										pPoints:uint, 
										pInnerRadius:Number, 
										pOuterRadius:Number, 
										pAngle:Number = 0):void {
			if(pPoints <= 2) {
				throw ArgumentError( "Shapes.drawStar: pPoints is too small, 3 minimum to build polygon!" ); 
				return;
			}
			
			var step:Number     = (Math.PI * 2) / pPoints;;
			var halfStep:Number = step / 2;
			var start:Number    = (pAngle / 180) * Math.PI;
			
			pTarget.moveTo(pX + (Math.cos(start) * pOuterRadius), 
						   pY - (Math.sin(start) * pOuterRadius));
			
			for (var n:Number = 1; n <= pPoints; ++n) {
				var dx:Number = pX + Math.cos(start + (step * n) - halfStep) * pInnerRadius;
				var dy:Number = pY - Math.sin(start + (step * n) - halfStep) * pInnerRadius;
				
				pTarget.lineTo(dx, dy);
				
				dx = pX + Math.cos(start + (step * n)) * pOuterRadius;
				dy = pY - Math.sin(start + (step * n)) * pOuterRadius;
				
				pTarget.lineTo(dx, dy);
			}
		};
		
		public static function drawSpiral(pTarget:Graphics, pRadius:int, 
										  pSides:int, pCoils:int):void {
			pTarget.moveTo(0, 0);
			
			var awayStep:Number   = pRadius / pSides;
			var aroundStep:Number = pCoils  / pSides;
			
			var aroundRadians:Number = aroundStep * 2 * Math.PI;
			
			for(var i:int = 1; i <= pSides; i++){
				var away:Number   = i * awayStep;
				var around:Number = i * aroundRadians;
				
				var x:Number = Math.cos(around) * away;
				var y:Number = Math.sin(around) * away;
				
				pTarget.lineTo(x, y);
			}
		};
	};
}