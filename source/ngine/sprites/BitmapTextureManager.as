package ngine.sprites {
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	
	public class BitmapTextureManager extends AbstractTextureManager {
		
		public function BitmapTextureManager() {
			super();
		};
		
		private function parseTexure(pID:String, pTexture:BitmapData):void {
			addTexure(pID, Texture.fromBitmapData(pTexture, false, false, scale));
		};
	}
}