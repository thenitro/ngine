package com.thenitro.ngine.display.gameentity.collider {
	import com.thenitro.ngine.collections.LinkedList;
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.Pool;
	
	public final class LinearCollider implements ICollider {
		private static var _pool:Pool = Pool.getInstance();
		
		private var _entities:LinkedList;
		private var _colliderMethod:Function;
		
		public function LinearCollider(pColliderMethod:Function) {
			_colliderMethod = pColliderMethod;
			
			_entities = _pool.get(LinkedList) as LinkedList;
			
			if (!_entities) {
				_entities = new LinkedList();
				_pool.allocate(LinkedList, 1);
			}
		};
		
		public function addEntity(pEntity:Entity):void {
			_entities.add(pEntity);
		};
		
		public function removeEntity(pEntity:Entity):void {
			_entities.remove(pEntity);
		};
		
		public function getNearbyEntities(pPosition:Vector2D, 
										  pRadius:Number):Array {
			var result:Array = [];
			
			var entity:Entity = _entities.first as Entity;
			
			while (entity) {
				if (Vector2D.distanceSquared(entity.position, pPosition) < pRadius * pRadius) {
					result.push(entity);
				}
				
				entity = _entities.next(entity) as Entity;
			}
			
			return result;
		};
		
		public function update():void {
			var entityA:Entity = _entities.first as Entity;
			
			while (entityA) {
				var entityB:Entity = _entities.first as Entity;
				
				while (entityB) {
					if (isColliding(entityA, entityB)) {
						trace("LinearCollider.update()", entityA, entityB);
						
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