package ngine.sprites {
	import starling.display.Stage;
	import starling.textures.Texture;
	
	public class AbstractTextureManager {
		private var _textures:Object;
		private var _scale:Number;
		
		public function AbstractTextureManager() {
			_textures = {};
		};
		
		public function get scale():Number {
			return _scale;
		};
		
		public function init(pStage:Stage, 
							 pReferenceWidth:Number, pReferenceHeight:Number):void {
			var scaleX:Number = pStage.stageWidth  / pReferenceWidth;
			var scaleY:Number = pStage.stageHeight / pReferenceHeight;
			
			_scale = Math.min(scaleX, scaleY);
		};
		
		public function parse():void {
			
		};
		
		public function getTexture(pID:String):Texture {
			return _textures[pID] as Texture;
		};
		
		protected function addTexure(pID:String, pTexture:Texture):void {
			_textures[pID] = pTexture;
		};
	}
}