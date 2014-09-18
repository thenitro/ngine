package ngine.display {
    import ngine.display.scale.IScalable;

    import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public final class TilingTexture extends Sprite implements IScalable {
        public static const ALIGN_RIGHT:int  = -1;
        public static const ALIGN_LEFT:int   =  1;
        public static const ALIGN_CENTER:int =  0;

		private var _texture:Texture;
		
		private var _width:Number;
		private var _height:Number;

        private var _align:int;

        private var _scale:Number;
        private var _scaleFactor:Number;

		public function TilingTexture(pTexture:Texture,
                                      pWidth:Number, pHeight:Number,
                                      pAlign:int = ALIGN_LEFT) {
			_texture = pTexture;
			
			_width  = pWidth;
			_height = pHeight;

            _align = pAlign;

            _scale = 1.0;
            _scaleFactor = 1.0;
			
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageEventHandler);
		};

        public function scale(pScale:Number, pScaleFactor:Number):void {
            _scale       = pScale;
            _scaleFactor = pScaleFactor;

            resize(_width, _height);
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
            unflatten();

            var sWidth:Number  = _width  * _scaleFactor;
            var sHeight:Number = _height * _scaleFactor;

            var startX:int = 0;
            var startY:int = 0;

            var endX:int = Math.ceil(sWidth / _texture.width);
            var endY:int = Math.ceil(sHeight / _texture.height);

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

                        image.x = i * _texture.width;
                        image.y = j * _texture.height;

                    addChild(image);
                }
            }

            flatten();
        };
	};
}