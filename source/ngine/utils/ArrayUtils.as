package ngine.utils {
    import flash.errors.IllegalOperationError;

    public class ArrayUtils {
        public function ArrayUtils() {
            throw new IllegalOperationError('ArrayUtils is static!');
        };

        public static function removeElement(pArray:Array, pElement:Object):void {
            pArray.splice(pArray.indexOf(pElement), 1);
        };
    }
}
