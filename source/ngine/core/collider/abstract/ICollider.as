package ngine.core.collider.abstract {
    import ngine.core.Entity;

    import nmath.vectors.Vector2D;

    public interface ICollider {
		function setup(pParameters:IColliderParameters):void;
		
		function addEntity(pEntity:Entity):void;
		function removeEntity(pEntity:Entity):void;
		
		function update(pElapsed:Number):void;
		
		function getNearbyEntities(pPosition:Vector2D, pRadius:Number,
								   pFilterFunction:Function = null,
								   pSorted:Boolean = false):Array;
		function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean;
	};
}