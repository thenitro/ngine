package com.thenitro.ngine.display.gameentity.collider {
	import com.thenitro.ngine.display.gameentity.Entity;
	import com.thenitro.ngine.math.vectors.Vector2D;
	
	public interface ICollider {		
		function addEntity(pEntity:Entity):void;
		function removeEntity(pEntity:Entity):void;
		
		function update():void;
		
		function getNearbyEntities(pPosition:Vector2D, pRadius:Number):Array;
		function isColliding(pEntityA:Entity, pEntityB:Entity):Boolean;
	};
}