package ngine.core.collider {
	import ncollections.LinkedList;
	
	import ngine.core.Entity;
	import ngine.core.collider.abstract.ICollider;
	import ngine.core.collider.abstract.IColliderParameters;
	import ngine.core.collider.parameters.LinearColliderParameters;
	import ngine.math.vectors.Vector2D;
	
	import npooling.Pool;
	
	public class LinearCollider implements ICollider {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _entities:LinkedList;
		private var _parameters:LinearColliderParameters;
		
		public function LinearCollider() {
			_entities = LinkedList.EMPTY;
		};
		
		public function setup(pParameters:IColliderParameters):void {
			_pool.put(_parameters);
			_parameters = pParameters as LinearColliderParameters;
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
		
		public function update(pElapsed:Number):void {
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
			
			return _parameters.colliderMethod(pEntityA, pEntityB);
		};
	}
}