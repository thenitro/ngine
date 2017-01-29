package ngine.display {
    import flash.utils.Dictionary;

    import nmath.NMath;
    import nmath.vectors.Vector2D;

    import starling.display.Sprite;
    import starling.textures.Texture;

    public class ParallaxSprite extends Sprite {
        private var _layers:Vector.<TilingTexture>;
        private var _multiply:Dictionary;

        private var _width:Number;
        private var _height:Number;

        public function ParallaxSprite() {
            _layers   = new Vector.<TilingTexture>();
            _multiply = new Dictionary();

            super();
        };

        public function get layers():Vector.<TilingTexture> {
            return _layers;
        };

        public function addLayer(pTexture:Texture,
                                 pTextureScale:Number,
                                 pWidth:Number,
                                 pHeight:Number,
                                 pMultiply:Number):void {
            _width = pWidth;
            _height = pHeight;

            var texture:TilingTexture =
                    new TilingTexture(
                            pTexture, pTextureScale,
                            _width, _height,
                            TilingTexture.ALIGN_CENTER);

            _layers.push(texture);
            _multiply[texture] = pMultiply;

            addChild(texture);
        };

        public function offset(pOffset:Vector2D):void {
            for each (var texture:TilingTexture in _layers) {
                if (_multiply[texture] == 0.0) {
                    continue;
                }

                texture.y = Math.round(pOffset.y * _multiply[texture]);
            }
        };

        public function setColor(pColor:uint):void {
            for each (var layer:TilingTexture in _layers) {
                layer.setColor(pColor);
            }
        }

        public function resize(pWidth:Number, pHeight:Number):void {
            _width = pWidth;
            _height = pHeight;

            for each (var texture:TilingTexture in _layers) {
                texture.resize(_width, _height);
            }
        };
    };
}
