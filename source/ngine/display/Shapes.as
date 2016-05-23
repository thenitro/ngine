package ngine.display {
	import flash.geom.Point;

	import starling.geom.Polygon;

	public final class Shapes {
		
		public function Shapes() {
			
		};
		
		public static function drawStar(pTarget:Polygon,
										pX:Number, pY:Number, 
										pPoints:uint, 
										pInnerRadius:Number, 
										pOuterRadius:Number, 
										pAngle:Number = 0):Polygon {
			if(pPoints <= 2) {
				throw ArgumentError( "Shapes.drawStar: pPoints is too small, 3 minimum to build polygon!" ); 
				return null;
			}
			
			var step:Number     = (Math.PI * 2) / pPoints;;
			var halfStep:Number = step / 2;
			var start:Number    = (pAngle / 180) * Math.PI;

			pTarget.addVertices(
					new Point(
							pX + (Math.cos(start) * pOuterRadius),
							pY - (Math.sin(start) * pOuterRadius)));
			
			for (var n:Number = 1; n <= pPoints; ++n) {
				var dx:Number = pX + Math.cos(start + (step * n) - halfStep) * pInnerRadius;
				var dy:Number = pY - Math.sin(start + (step * n) - halfStep) * pInnerRadius;
				
				pTarget.addVertices(new Point(dx, dy));
				
				dx = pX + Math.cos(start + (step * n)) * pOuterRadius;
				dy = pY - Math.sin(start + (step * n)) * pOuterRadius;

				pTarget.addVertices(new Point(dx, dy));
			}

			return pTarget;
		};
		
		public static function drawSpiral(pTarget:Polygon, pRadius:int,
										  pSides:int, pCoils:int):Polygon {

			pTarget.addVertices(new Point(0, 0));
			
			var awayStep:Number   = pRadius / pSides;
			var aroundStep:Number = pCoils  / pSides;
			
			var aroundRadians:Number = aroundStep * 2 * Math.PI;
			
			for(var i:int = 1; i <= pSides; i++){
				var away:Number   = i * awayStep;
				var around:Number = i * aroundRadians;
				
				var x:Number = Math.cos(around) * away;
				var y:Number = Math.sin(around) * away;

				pTarget.addVertices(new Point(x, y));
			}

			return pTarget;
		};
	};
}