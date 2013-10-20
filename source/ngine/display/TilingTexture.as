package ngine.display {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public final class TilingTexture extends Sprite {
		private var _texture:Texture;
		
		private var _width:Number;
		private var _height:Number;
		
		public function TilingTexture(pTexture:Texture, pWidth:Number, pHeight:Number) {
			_texture = pTexture;
			
			_width  = pWidth;
			_height = pHeight;
			
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};
		
		private function addedToStageEventHandler(pEvent:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
			
			for (var i:uint = 0; i < Math.ceil(_width / _texture.width); i++) {
				for (var j:uint = 0; j < Math.ceil(_height / _texture.height); j++) {
					var image:Image = new Image(_texture);
						image.x = i * (_texture.width - 2);
						image.y = j * (_texture.height - 2);
					
					addChild(image);	
				}
			}			
		};
	};
}