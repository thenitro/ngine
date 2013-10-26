package ngine.core.manager {
	import flash.utils.getTimer;
	
	import ngine.collections.LinkedList;
	import ngine.core.Entity;
	import ngine.core.collider.ICollider;
	import ngine.math.vectors.Vector2D;
	import ngine.pool.IReusable;
	import ngine.pool.Pool;
	
	import starling.events.EventDispatcher;
	
	public final class EntityManager extends EventDispatcher implements IReusable {
		public static const ADDED:String   = 'added_event';
		public static const EXPIRED:String = 'expired_event';
		
		private static var _pool:Pool = Pool.getInstance();
		
		private var _entities:LinkedList;
		
		private var _addedEntities:Array;
		private var _expired:Array;
		
		private var _updating:Boolean;
		
		private var _collider:ICollider;
		
		private var _oldTime:int;
		
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
										  pRadius:Number, 
										  pFilterFunction:Function = null, 
										  pSorted:Boolean = false):Array {
			return _collider.getNearbyEntities(pPosition, pRadius, pFilterFunction, pSorted);
		};
		
		public function update():void {
			var time:int       = getTimer();
			var elapsed:Number = (time - _oldTime) / 1000;
			
			_oldTime  = time;
			_updating = true;
			
			var entity:Entity = _entities.first as Entity;
			
			if (_collider) {
				_collider.update(elapsed);
			}
			
			while (entity) {
				entity.update(elapsed);
				
				if (entity.expired) {
					_expired.push(entity);
				}
				
				entity = _entities.next(entity) as Entity;
			}
			
			_updating = false;
			
			for each (entity in _addedEntities) {
				addToStack(entity);
			}
			
			_addedEntities.length = 0;
			
			for each (entity in _expired) {
				removeFromStack(entity);
			}
			
			_expired.length = 0;
		};
		
		private function addToStack(pEntity:Entity):void {
			_entities.add(pEntity);
			
			if (_collider) {
				_collider.addEntity(pEntity);
			}
			
			dispatchEventWith(ADDED, false, pEntity);
		};
		
		private function removeFromStack(pEntity:Entity):void {
			if (_updating) {
				pEntity.expire(false);
				
				_expired.push(pEntity);
				
				return;
			}
			
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