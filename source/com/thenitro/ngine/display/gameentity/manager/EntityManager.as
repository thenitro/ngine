package com.thenitro.ngine.display.gameentity.manager {
	import com.thenitro.ngine.collections.LinkedList;
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.display.gameentity.collider.ICollider;
	import com.thenitro.ngine.math.vectors.Vector2D;
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
	import starling.events.EventDispatcher;
	
	public final class EntityManager extends EventDispatcher implements IReusable {
		public static const EXPIRED:String   = 'expired_event';
		
		private static var _pool:Pool = Pool.getInstance();
		
		private var _entities:LinkedList;
		
		private var _addedEntities:Array;
		private var _expired:Array;
		
		private var _updating:Boolean;
		
		private var _collider:ICollider;
		
		public function EntityManager() {
			_entities = _pool.get(LinkedList) as LinkedList;
			
			if (!_entities) {
				_entities = new LinkedList();
				_pool.allocate(LinkedList, 1);
			}
			
			_addedEntities = [];
			_expired       = [];
		};
		
		public function get reflection():Class {
			return EntityManager;
		};
		
		public function get entities():LinkedList {
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
			
			var entity:Entity = _entities.first as Entity;
			
			while (entity) {
				entity.update();
				entity = _entities.next(entity) as Entity;
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
			
			entity = _entities.first as Entity;
			
			while (entity) {
				if (entity.expired) {
					_expired.push(entity);
				}
				
				entity = _entities.next(entity) as Entity;
			}
			
			for each (entity in _expired) {
				removeFromStack(entity);
			}
		};
		
		private function addToStack(pEntity:Entity):void {
			_entities.add(pEntity);
			
			if (_collider) {
				_collider.addEntity(pEntity);
			}
		};
		
		private function removeFromStack(pEntity:Entity):void {
			dispatchEventWith(EXPIRED, false, pEntity);
			
			_entities.remove(pEntity);
			
			if (_collider) {
				_collider.removeEntity(pEntity);
			}
			
			_pool.put(pEntity);
		};
		
		public function clean():void {
			var entity:Entity = _entities.first as Entity;
			
			while (entity) {
				entity.expire(false);
				entity = _entities.next(entity) as Entity;
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