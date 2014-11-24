package ngine.tests {
    import flash.events.Event;

    import ncollections.grid.Grid;

    import ngine.display.hexagonalgrid.HexagonalGrid;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.async.Async;

    import starling.core.Starling;

    public class HexagonalGridTests {
        private static var _starling:Starling;

        public function HexagonalGridTests() {

        };

        [BeforeClass(async, ui)]
        public static function beforeClass():void {
            Async.proceedOnEvent(HexagonalGridTests, Main.currentStage, Event.COMPLETE, 1000);

            _starling = new Starling(FlexUnitStarlingIntegration, Main.currentStage);
            _starling.start();
        };

        [AfterClass]
        public static function afterClass():void {
            _starling.stop();
            _starling.dispose();
            _starling = null;
        };

        [Test]
        public function addManualTest():void {
            var grid:HexagonalGrid = new HexagonalGrid();
                grid.init(10, 10);

            var object:HexagonalElement = new HexagonalElement();

            assertEquals(0, object.indexX);
            assertEquals(0, object.indexY);

            assertEquals(0, object.position.x);
            assertEquals(0, object.position.y);

            grid.add(0, 0, object);

            assertEquals(0, object.indexX);
            assertEquals(0, object.indexY);

            assertEquals(0, object.position.x);
            assertEquals(0, object.position.y);

            assertEquals(object, grid.take(0, 0));

            var object2:HexagonalElement = new HexagonalElement();

            grid.add(0, 1, object2);

            assertEquals(0, object2.indexX);
            assertEquals(1, object2.indexY);

            assertEquals(-5, object2.position.x);
            assertEquals(10, object2.position.y);

            assertEquals(object2, grid.take(0, 1));

            var object3:HexagonalElement = new HexagonalElement();

            grid.add(0, 2, object3);

            assertEquals(0, object3.indexX);
            assertEquals(2, object3.indexY);

            assertEquals( 0, object3.position.x);
            assertEquals(20, object3.position.y);

            assertEquals(object3, grid.take(0, 2));

            var object4:HexagonalElement = new HexagonalElement();

            grid.add(1, 2, object4);

            assertEquals(1, object4.indexX);
            assertEquals(2, object4.indexY);

            assertEquals(10, object4.position.x);
            assertEquals(20, object4.position.y);

            assertEquals(object4, grid.take(1, 2));

            var object5:HexagonalElement = new HexagonalElement();

            grid.add(1, 3, object5);

            assertEquals(1, object5.indexX);
            assertEquals(3, object5.indexY);

            assertEquals(5, object5.position.x);
            assertEquals(30, object5.position.y);

            assertEquals(object5, grid.take(1, 3));
        }

        [Test]
        public function addAutomatedTest():void {
            var grid:HexagonalGrid = new HexagonalGrid();
                grid.init(10, 10);

            for (var i:int = 0; i < 1000; i++) {
                for (var j:int = 0; i < 1000; i++) {
                    var object:HexagonalElement = new HexagonalElement();

                    assertEquals(0, object.indexX);
                    assertEquals(0, object.indexY);

                    assertEquals(0, object.position.x);
                    assertEquals(0, object.position.y);

                    assertNull(grid.take(i, j));

                    grid.add(i, j, object);

                    assertEquals(i, object.indexX);
                    assertEquals(j, object.indexY);

                    var positionX:Number = 10 * i;
                    if (j % 2) {
                        positionX -= 5;
                    }

                    var positionY:Number = 10 * j;

                    assertEquals(positionX, object.position.x);
                    assertEquals(positionY, object.position.y);

                    assertEquals(object, grid.take(i, j));
                }
            }
        };

        [Test]
        public function offsetTestManual():void {
            var grid:HexagonalGrid = new HexagonalGrid();
                grid.init(10, 10, 100, 100);

            var object:HexagonalElement = new HexagonalElement();

            assertEquals(0, object.indexX);
            assertEquals(0, object.indexY);

            assertEquals(0, object.position.x);
            assertEquals(0, object.position.y);

            grid.add(1, 1, object);

            assertEquals(1, object.indexX);
            assertEquals(1, object.indexY);

            assertEquals(105, object.position.x);
            assertEquals(110, object.position.y);

            assertEquals(object, grid.take(1, 1));
        };
    }

}
