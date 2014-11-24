package ngine.tests {
    import ncollections.grid.IGridObject;

    import ngine.display.hexagonalgrid.IHexagonalObject;

    import nmath.vectors.Vector2D;

    import starling.display.DisplayObject;

    import starling.display.Sprite;

    public class HexagonalElement implements IHexagonalObject {
        private var _position:Vector2D;
        private var _canvas:Sprite;

        private var _disposed:Boolean;

        private var _indexX:int = 0;
        private var _indexY:int = 0;

        public function HexagonalElement() {
            _position = Vector2D.ZERO;
            _canvas   = new Sprite();
        };

        public function get reflection():Class {
            return HexagonalElement;
        };

        public function get disposed():Boolean {
            return _disposed;
        };

        public function get position():Vector2D {
            return _position;
        };

        public function get canvas():DisplayObject {
            return _canvas;
        };

        public function get indexX():int {
            return _indexX;
        };

        public function get indexY():int {
            return _indexY;
        };

        public function updateIndex(pX:int, pY:int):void {
            _indexX = pX;
            _indexY = pY;
        };

        public function clone():IGridObject {
            var result:HexagonalElement = new HexagonalElement();

                result.position.x = position.x;
                result.position.y = position.y;

                result.updateIndex(_indexX, _indexY);

            return result;
        };

        public function poolPrepare():void {
            
        };

        public function dispose():void {

        };
    };
}
