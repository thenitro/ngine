package com.thenitro.ngine.display.gameentity.collider {
	import com.thenitro.ngine.collections.LinkedList;
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.Pool;
	
	public final class LinearCollider implements ICollider {
		private static var _pool:Pool = Pool.getInstance(); 
		private var _entities:LinkedList;
		
		public function LinearCollider() {
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
					if (isColliding(entity, entityB)) {
						entity.handleCollision(entityB);
						entityB.handleCollision(entity);
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
			
			if (!pEntityA.radius || !pEntityB.radius) {
				return false;
			}
			
			var radius:Number = pEntityA.radius + pEntityB.radius;
			
			return Vector2D.distanceSquared(pEntityA.position, pEntityB.position) < radius * radius;
		};
	}
}