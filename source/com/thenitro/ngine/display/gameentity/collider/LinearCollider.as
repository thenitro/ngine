package com.thenitro.ngine.display.gameentity.collider {
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.math.vectors.Vector2D;
	
	public final class LinearCollider implements ICollider {
		private var _entities:Array;
		
		public function LinearCollider() {
			_entities = [];
		};
		
		public function addEntity(pEntity:Entity):void {
			_entities.push(pEntity);
		};
		
		public function removeEntity(pEntity:Entity):void {
			_entities.splice(_entities.indexOf(pEntity), 1);
		};
		
		public function getNearbyEntities(pPosition:Vector2D, 
										  pRadius:Number):Array {
			var result:Array = [];
			
			for each (var entity:Entity in _entities) {
				if (entity.expired) {
					continue;
				}
				
				if (Vector2D.distanceSquared(entity.position, pPosition) < pRadius * pRadius) {
					result.push(entity);
				}
			}
			
			return result;
		};
		
		public function update():void {
			for each (var entity:Entity in _entities) {
				for each (var entityB:Entity in _entities) {
					if (entity == entityB) {
						continue;
					}
					
					if (isColliding(entity, entityB)) {
						entity.handleCollision(entityB);
						entityB.handleCollision(entity);
					}
				}
			}
		};
		
		public function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean {
			if (pEntityA.expired || pEntityB.expired) {
				return false;
			}
			
			if (!pEntityA.radius || !pEntityB.radius) {
				return false;
			}
			
			var radius:Number = pEntityA.radius + pEntityB.radius;
			
			return Vector2D.distanceSquared(pEntityA.position, pEntityB.position) < radius * radius;
		};
	}
}