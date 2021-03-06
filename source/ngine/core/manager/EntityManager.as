package ngine.core.manager {
    import ncollections.LinkedList;

    import ngine.core.Entity;
    import ngine.core.collider.abstract.ICollider;

    import nmath.vectors.Vector2D;

    import npooling.IReusable;
    import npooling.Pool;

    import starling.events.EventDispatcher;

    public final class EntityManager extends EventDispatcher implements IReusable {
		public static const ADDED:String   = 'added_event';
		public static const EXPIRED:String = 'expired_event';
		
		private static var _pool:Pool = Pool.getInstance();

        private var _disposed:Boolean;
		
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

		public static function get NEW():EntityManager {
			return _pool.get(EntityManager) as EntityManager;
		}
		
		public function get reflection():Class {
			return EntityManager;
		};

        public function get disposed():Boolean {
            return _disposed;
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
			return _collider.getNearbyEntities(pPosition, pRadius, 
											   pFilterFunction, pSorted);
		};
		
		public function update(pElapsed:Number):void {
			_updating = true;
			
			var entity:Entity = _entities.first as Entity;
			
			if (_collider) {
				_collider.update(pElapsed);
			}
			
			while (entity) {
				entity.update(pElapsed);
				
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
				pEntity.expire();
				
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
				entity.expire();
				entity = _entities.next(entity) as Entity;
			}
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();

            _disposed = true;
		};
	};
}