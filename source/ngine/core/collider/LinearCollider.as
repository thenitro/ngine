package ngine.core.collider {
	import ndatas.LinkedList;
	import ngine.core.Entity;
	import ngine.math.vectors.Vector2D;
	
	public class LinearCollider implements ICollider {
		private var _entities:LinkedList;
		private var _colliderMethod:Function;
		
		public function LinearCollider(pColliderMethod:Function) {
			_colliderMethod = pColliderMethod;
			_entities       = LinkedList.EMPTY;
		};
		
		public function addEntity(pEntity:Entity):void {
			_entities.add(pEntity);
		};
		
		public function removeEntity(pEntity:Entity):void {
			_entities.remove(pEntity);
		};
		
		public function getNearbyEntities(pPosition:Vector2D, 
										  pRadius:Number, 
										  pFilterFunction:Function = null, 
										  pSorted:Boolean = false):Array {
			var result:Array = [];
			
			var entity:Entity = _entities.first as Entity;
			
			while (entity) {
				if (Vector2D.distanceSquared(entity.position, pPosition) < pRadius * pRadius) {
					if (pFilterFunction == null || pFilterFunction(entity)) {
						result.push(entity);
					}
				}
				
				entity = _entities.next(entity) as Entity;
			}
			
			if (pSorted) {
				result.sort(function(pA:Entity, pB:Entity):int {
					if (Vector2D.distanceSquared(pA.position, pPosition) > Vector2D.distanceSquared(pB.position, pPosition)) {
						return 1;
					}
					
					return -1;
				});
			}
			
			return result;
		};
		
		public function update():void {
			var entityA:Entity = _entities.first as Entity;
			
			while (entityA) {
				var entityB:Entity = _entities.first as Entity;
				
				while (entityB) {
					if (isColliding(entityA, entityB)) {
						entityA.handleCollision(entityB);
						entityB.handleCollision(entityA);
					}
					
					entityB = _entities.next(entityB) as Entity;
				}
				
				entityA = _entities.next(entityA) as Entity;
			}
		};
		
		public function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean {
			if (pEntityA == pEntityB) {
				return false;
			}
			
			if (pEntityA.expired || pEntityB.expired) {
				return false;
			}
			
			if (!pEntityA.size || !pEntityB.size) {
				return false;
			}
			
			return _colliderMethod(pEntityA, pEntityB);
		};
	}
}