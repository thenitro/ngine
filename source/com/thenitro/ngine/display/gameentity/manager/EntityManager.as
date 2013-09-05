package com.thenitro.ngine.display.gameentity.manager {
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
	import starling.events.EventDispatcher;
	
	public final class EntityManager extends EventDispatcher implements IReusable {
		public static const EXPIRED:String   = 'expired_event';
		
		private static var _pool:Pool = Pool.getInstance();
		
		private var _entities:Array;
		private var _addedEntities:Array;
		
		private var _updating:Boolean;
		
		private var _useCollision:Boolean;
		
		public function EntityManager() {
			_entities      = [];
			_addedEntities = [];
		};
		
		public function get reflection():Class {
			return EntityManager;
		};
		
		public function get entities():Array {
			return _entities;
		};
		
		public function init(pUseCollision:Boolean):void {
			_useCollision = pUseCollision;
		};
		
		public function add(pEntity:Entity):void {
			if (_updating) {
				_addedEntities.push(pEntity);
			} else {
				_entities.push(pEntity);
			}
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
			_updating = true;
			
			var entity:Entity;
			
			for each (entity in _entities) {
				entity.update();
			}
			
			for each (entity in _entities) {
				for each (var entityB:Entity in _entities) {
					if (entity == entityB) {
						continue;
					}
					
					if (_useCollision && isColliding(entity, entityB)) {
						entity.handleCollision(entityB);
						entityB.handleCollision(entity);
					}
				}
			}
			
			_updating = false;
			
			for each (entity in _addedEntities) {
				_entities.push(entity);
			}
			
			_addedEntities.length = 0;
			
			var expired:Array = [];
			
			for each (entity in _entities) {
				if (entity.expired) {
					dispatchEventWith(EXPIRED, false, entity);
					
					_entities.splice(_entities.indexOf(entity), 1);
					_pool.put(entity);
				}
			}
			
			for each (entity in expired) {
				dispatchEventWith(EXPIRED, false, entity);
				
				_entities.splice(_entities.indexOf(entity), 1);				
				
			}
		};
		
		public function poolPrepare():void {
			
		};
		
		public function dispose():void {
			
		};
		
		private function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean {
			if (pEntityA.expired || pEntityB.expired) {
				return false;
			}
			
			var radius:Number = pEntityA.radius + pEntityB.radius;
			
			return Vector2D.distanceSquared(pEntityA.position, pEntityB.position) < radius * radius;
		};
	};
}