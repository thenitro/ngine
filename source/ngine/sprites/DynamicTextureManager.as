package ngine.sprites {
	import com.emibap.textureAtlas.DynamicAtlas;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import starling.textures.TextureAtlas;

	public class DynamicTextureManager extends AbstractTextureManager {

		public function DynamicTextureManager() {
		};
		
		protected function convertToTextures(pTarget:Sprite):void {
			var i:int;
			var child:DisplayObject;
			
			for (i = 0; i < pTarget.numChildren; i++) {
				child = pTarget.getChildAt(i);
			}

			var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(pTarget, scale, 0, true, true);
			
			for (i = 0; i < pTarget.numChildren; i++) {				
				child = pTarget.getChildAt(i);
				addTexure(child.name, atlas.getTextures(child.name)[0]);
			}
		};
	};
}