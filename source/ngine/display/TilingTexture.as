package ngine.display {
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    public final class TilingTexture extends Sprite {
        public static const ALIGN_RIGHT:int  = -1;
        public static const ALIGN_LEFT:int   =  1;
        public static const ALIGN_CENTER:int =  0;

		private var _texture:Texture;
        private var _textureScale:Number;
		
		private var _width:int;
		private var _height:int;

        private var _align:int;

		public function TilingTexture(pTexture:Texture, pTextureScale:Number,
                                      pWidth:int, pHeight:int,
                                      pAlign:int = ALIGN_LEFT) {
			_texture = pTexture;
            _textureScale = pTextureScale;

			_width  = pWidth == - 1 ? _texture.width * pTextureScale : pWidth;
			_height = pHeight == -1 ? _texture.height * pTextureScale : pHeight;

            _align = pAlign;

			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};

        public function resize(pWidth:Number, pHeight:Number):void {
            _width  = pWidth;
            _height = pHeight;

            removeChildren(0, -1, true);
            createTextures();
        };
		
		private function addedToStageEventHandler(pEvent:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
			createTextures();
		};

        private function createTextures():void {
            var startX:int = 0;
            var startY:int = 0;

            var endX:int = Math.ceil(_width / (_texture.width * _textureScale));
            var endY:int = Math.ceil(_height / (_texture.height * _textureScale));

            if (_align == ALIGN_LEFT || _align == ALIGN_RIGHT) {
                startX = 0;
            }

            if (_align == ALIGN_RIGHT) {
                endX = 0;

                startX = -endX;
            }

            if (_align == ALIGN_CENTER) {
                startX = -endX;
            }

            for (var i:int = startX; i < endX; i++) {
                for (var j:int = startY; j < endY; j++) {
                    var image:Image = new Image(_texture);
                        image.textureSmoothing = TextureSmoothing.NONE;

                        image.x = i * _texture.width;
                        image.y = j * _texture.height;

                    addChild(image);
                }
            }
        };
	};
}