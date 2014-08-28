package ngine.display {
    import flash.events.PressAndTapGestureEvent;
    import flash.utils.Dictionary;

    import nmath.TMath;

    import nmath.vectors.Vector2D;

    import starling.display.Sprite;
    import starling.textures.Texture;

    public class ParallaxSprite extends Sprite {
        private var _layers:Vector.<TilingTexture>;
        private var _multiply:Dictionary;

        private var _width:Number;

        public function ParallaxSprite() {
            _layers   = new Vector.<TilingTexture>();
            _multiply = new Dictionary();

            super();
        };

        public function get layers():Vector.<TilingTexture> {
            return _layers;
        };

        public function addLayer(pTexture:Texture,
                                 pWidth:Number,
                                 pMultiply:Number):void {
            _width  = pWidth;

            var texture:TilingTexture = new TilingTexture(pTexture, _width + _width * (1.0 - pMultiply), pTexture.height);

            _layers.push(texture);
            _multiply[texture] = pMultiply;

            addChild(texture);
            resizeTexture(texture, _width);
        };

        public function offset(pOffset:Vector2D):void {
            for each (var texture:TilingTexture in _layers) {
                if (_layers[0] == texture) {
                    continue;
                }

                texture.x -= Math.round(pOffset.x * _multiply[texture]);
                texture.x  = TMath.clamp(texture.x, 0, texture.width - _width);
            }
        };

        public function resize(pWidth:Number):void {
            _width  = pWidth;

            for each (var texture:TilingTexture in _layers) {
                resizeTexture(texture, pWidth);
            }
        };

        private function resizeTexture(pTexture:TilingTexture,
                                       pWidth:Number):void {
            pTexture.resize(pWidth, pTexture.height);
            pTexture.x = (pWidth - pTexture.width) / 2;

            if (pTexture == _layers[0]) {
                return;
            }

            pTexture.y = _layers[0].height - pTexture.height;
        };
    };
}
