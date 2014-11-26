package ngine.display.hexagonalgrid {
    import ncollections.grid.Grid;

    import nmath.vectors.Vector2D;

    public class HexagonalGrid extends Grid {
        private var _tileWidth:Number;
        private var _tileHeight:Number;

        private var _offsetX:Number;
        private var _offsetY:Number;

        private var _inited:Boolean;

        public function HexagonalGrid() {
            super();
        };

        override public function add(pX:int, pY:int, pObject:Object):Object {
            if (!_inited) {
                trace('HexagonalGridContainer.add: not inited!');
                return null;
            }

            if (!(pObject is IHexagonalObject)) {
                trace('HexagonalGrid.add: must be implementation of IHexagonalObject');
                return null;
            }

            var object:IHexagonalObject = pObject as IHexagonalObject;
                object.position.x = _offsetX + pX * _tileWidth;
                if (pY % 2) {
                    object.position.x -= _tileWidth / 2;
                }

                object.position.y = _offsetY + pY * _tileHeight;

            return super.add(pX, pY, pObject);
        };

        public function init(pTileWidth:Number, pTileHeight:Number,
                             pOffsetX:Number = 0, pOffsetY:Number = 0):void {
            if (pTileWidth < 1 || pTileHeight < 1) {
                trace('HexagonalGridContainer.init: tile width and height cannot be 0 or less');
                return;
            }

            _tileWidth  = pTileWidth;
            _tileHeight = pTileHeight;

            _offsetX = pOffsetX;
            _offsetY = pOffsetY;

            _inited = true;
        };

        public function takeNeighborsFor(pIndexX:int, pIndexY:int):Array {
            var result:Array = [];
            var offsetX:int  = 1;

            if (pIndexY % 2) {
                offsetX = -1;
            }

            //TOP
            result.push(take(pIndexX + offsetX, pIndexY - 1));
            result.push(take(pIndexX,           pIndexY - 1));

            //MIDDLE
            result.push(take(pIndexX - 1, pIndexY));
            result.push(take(pIndexX + 1, pIndexY));

            //BOTTOM
            result.push(take(pIndexX + offsetX, pIndexY + 1));
            result.push(take(pIndexX,           pIndexY + 1));

            return result;
        };

        public function takeNeighborsIndexesFor(pIndexX:int, pIndexY:int):Array {
            var result:Array = [];
            var offsetX:int  = 1;

            if (pIndexY % 2) {
                offsetX = -1;
            }

            //TOP
            result.push(pIndexX + offsetX, pIndexY - 1);
            result.push(pIndexX,           pIndexY - 1);

            //MIDDLE
            result.push(pIndexX - 1, pIndexY);
            result.push(pIndexX + 1, pIndexY);

            //BOTTOM
            result.push(pIndexX + offsetX, pIndexY + 1);
            result.push(pIndexX,           pIndexY + 1);

            return result;
        };
    }
}
