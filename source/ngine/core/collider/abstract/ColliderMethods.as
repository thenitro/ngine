package ngine.core.collider.abstract {
	import flash.errors.IllegalOperationError;
	
	import ngine.core.Entity;
	import ngine.math.TMath;
	import ngine.math.vectors.Vector2D;
	
	public final class ColliderMethods {
		
		public function ColliderMethods() {
			throw new IllegalOperationError("ColliderMethods is static!");
		};
		
		public static function circleToCirle(pEntityA:Entity,
											 pEntityB:Entity):Boolean {
			var radius:Number = pEntityA.size + pEntityB.size;
			
			return Vector2D.distanceSquared(pEntityA.position, pEntityB.position) < radius * radius;
		};
		
		public static function rectToRect(pEntityA:Entity,
										  pEntityB:Entity):Boolean {
			var overlapX:Boolean = TMath.valueInRange(pEntityA.position.x,
												      pEntityB.position.x,
													  pEntityB.position.x + pEntityB.size) || 
								   TMath.valueInRange(pEntityB.position.x,
									   				  pEntityA.position.x,
													  pEntityA.position.x + pEntityA.size);
			
			var overlapY:Boolean = TMath.valueInRange(pEntityA.position.y,
												      pEntityB.position.y,
													  pEntityB.position.y + pEntityB.size) || 
								   TMath.valueInRange(pEntityB.position.y,
									   				  pEntityA.position.y,
													  pEntityA.position.y + pEntityA.size);
			
			return overlapX && overlapY;
		};
	};
}