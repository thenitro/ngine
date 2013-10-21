package ngine.core.collider {
	import ngine.core.Entity;
	import ngine.math.vectors.Vector2D;
	
	public interface ICollider {		
		function addEntity(pEntity:Entity):void;
		function removeEntity(pEntity:Entity):void;
		
		function update(pElapsed:Number):void;
		
		function getNearbyEntities(pPosition:Vector2D, pRadius:Number):Array;
		function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean;
	};
}