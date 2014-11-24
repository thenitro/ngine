package ngine.display.hexagonalgrid {
    import ncollections.grid.IGridObject;

    import nmath.vectors.Vector2D;

    public interface IHexagonalObject extends IGridObject {
        function get position():Vector2D;
    }
}
