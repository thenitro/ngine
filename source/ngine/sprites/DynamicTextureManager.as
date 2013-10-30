package ngine.sprites {
	import com.emibap.textureAtlas.DynamicAtlas;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import starling.display.Stage;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class DynamicTextureManager extends AbstractTextureManager {
		
		public function DynamicTextureManager() {
			
		};
		
		protected function convertToTextures(pTarget:Sprite):void {
			var i:int;
			var child:DisplayObject;
			
			for (i = 0; i < pTarget.numChildren; i++) {
				child = pTarget.getChildAt(i);
				
				child.width  *= scale;
				child.height *= scale;
				
				child.width  = child.width  > 2048 ? 2048 : child.width;
				child.height = child.height > 2048 ? 2048 : child.height;
			}
			
			var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(pTarget, 1, 0, true, true);
			
			for (i = 0; i < pTarget.numChildren; i++) {
				child = pTarget.getChildAt(i);
				addTexure(child.name, atlas.getTextures(child.name)[0]);
			}
		};
	};
}