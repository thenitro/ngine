package ngine.sprites {
	import flash.display.BitmapData;

	import starling.display.Stage;
	import starling.textures.Texture;
	
	public class AbstractTextureManager {
		private static var _emptyBitmapData:BitmapData;
		private static var _emptyTexture:Texture;


		private var _textures:Object;
		private var _scale:Number;
		
		public function AbstractTextureManager() {
			_textures = {};
			_scale    = 1.0;
		};
		
		public function get scale():Number {
			return _scale;
		};

		public function get emptyBitmapData():BitmapData {
			return _emptyBitmapData;
		};

		public function get emptyTexture():Texture {
			return _emptyTexture;
		};
		
		public function init(pStage:Stage, 
							 pReferenceWidth:Number, pReferenceHeight:Number):void {
			var scaleX:Number = pStage.stageWidth  / pReferenceWidth;
			var scaleY:Number = pStage.stageHeight / pReferenceHeight;
			
			_scale = Math.min(scaleX, scaleY);

			if (!_emptyBitmapData && !_emptyTexture) {
				_emptyBitmapData = new BitmapData(2, 2, true, 0x00000000);
				_emptyTexture    = Texture.fromBitmapData(_emptyBitmapData);
			}
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