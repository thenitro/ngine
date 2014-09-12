package ngine.display {
    import com.wysegames.stolenkingdom.play.PlayState;

    import flash.utils.Dictionary;

    import ngine.display.scale.IScalable;

    import nmath.TMath;
    import nmath.vectors.Vector2D;

    import starling.display.Sprite;
    import starling.textures.Texture;

    public class ParallaxSprite extends Sprite implements IScalable {
        private var _layers:Vector.<TilingTexture>;
        private var _multiply:Dictionary;

        private var _width:Number;

        private var _scale:Number;
        private var _scaleFactor:Number;

        public function ParallaxSprite() {
            _layers   = new Vector.<TilingTexture>();
            _multiply = new Dictionary();

            _scale = 1.0;
            _scaleFactor = 1.0;

            super();
        };

        public function get layers():Vector.<TilingTexture> {
            return _layers;
        };

        public function addLayer(pTexture:Texture,
                                 pWidth:Number,
                                 pMultiply:Number):void {
            _width  = pWidth;

            var texture:TilingTexture = new TilingTexture(pTexture, _width, pTexture.height, TilingTexture.ALIGN_CENTER);

            _layers.push(texture);
            _multiply[texture] = pMultiply;

            addChild(texture);
            resizeTexture(texture, _width);
        };

        public function offset(pOffset:Vector2D):void {
            for each (var texture:TilingTexture in _layers) {
                if (_multiply[texture] == 0.0) {
                    continue;
                }

                texture.x -= Math.round(pOffset.x * _multiply[texture]);
                texture.x  = TMath.clamp(texture.x, -texture.width / 2 + (stage.stageWidth * _scaleFactor), 0);
            }
        };

        public function scale(pScale:Number, pScaleFactor:Number):void {
            trace('ParallaxSprite.scale:', pScale, pScaleFactor);

            _scale       = pScale;
            _scaleFactor = pScaleFactor;

            resize(_width);
        };

        public function resize(pWidth:Number):void {
            _width = pWidth;

            for each (var texture:TilingTexture in _layers) {
                resizeTexture(texture, _width * _scaleFactor);
            }
        };

        private function resizeTexture(pTexture:TilingTexture,
                                       pWidth:Number):void {
            pTexture.resize(pWidth, pTexture.height * _scale);

            trace('ParallaxSprite.resizeTexture:', pTexture.height);

            if (pTexture == _layers[0]) {
                return;
            }

            pTexture.y = _layers[0].height - pTexture.height;

            if (_multiply[pTexture] == 0.0) {
                return;
            }

            pTexture.x = (pWidth - pTexture.width) / 2;

            trace('ParallaxSprite.resizeTexture:', height);
        };
    };
}
