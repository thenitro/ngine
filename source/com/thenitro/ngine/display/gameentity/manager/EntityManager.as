package com.thenitro.ngine.display.gameentity.manager {
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.display.gameentity.collider.ICollider;
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
	import starling.events.EventDispatcher;
	
	public final class EntityManager extends EventDispatcher implements IReusable {
		public static const EXPIRED:String   = 'expired_event';
		
		private static var _pool:Pool = Pool.getInstance();
		
		private var _entities:Array;
		private var _addedEntities:Array;
		private var _expired:Array;
		
		private var _updating:Boolean;
		
		private var _collider:ICollider;
		
		public function EntityManager() {
			_entities      = [];
			_addedEntities = [];
			_expired       = [];
		};
		
		public function get reflection():Class {
			return EntityManager;
		};
		
		public function get entities():Array {
			return _entities;
		};
		
		public function setCollider(pCollider:ICollider):void {
			_collider = pCollider;
		};
		
		public function add(pEntity:Entity):void {			
			if (_updating) {				
				_addedEntities.push(pEntity);
			} else {
				addToStack(pEntity);
			}
		};
		
		public function remove(pEntity:Entity):void {
			removeFromStack(pEntity);
		};
		
		public function getNearbyEntities(pPosition:Vector2D, 
										  pRadius:Number):Array {
			return _collider.getNearbyEntities(pPosition, pRadius);
		};
		
		public function update():void {
			_updating = true;
			
			var entity:Entity;
			
			for each (entity in _entities) {
				if (entity.expired) {
					continue;
				}
				
				entity.update();
			}
			
			if (_collider) {
				_collider.update();
			}
			
			_updating = false;
			
			for each (entity in _addedEntities) {
				addToStack(entity);
			}
			
			_addedEntities.length = 0;
			_expired.length = 0;
			
			for each (entity in _entities) {
				if (entity.expired) {
					_expired.push(entity);
				}
			}
			
			for each (entity in _expired) {
				removeFromStack(entity);
			}
		};
		
		private function addToStack(pEntity:Entity):void {
			_entities.push(pEntity);
			
			if (_collider) {
				_collider.addEntity(pEntity);
			}
		};
		
		private function removeFromStack(pEntity:Entity):void {
			dispatchEventWith(EXPIRED, false, pEntity);
			
			_entities.splice(_entities.indexOf(pEntity), 1);
			
			if (_collider) {
				_collider.removeEntity(pEntity);
			}
			
			_pool.put(pEntity);
		};
		
		public function clean():void {
			for each (var entity:Entity in _entities) {
				entity.expire(false);
			}
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();			
		};
	};
}