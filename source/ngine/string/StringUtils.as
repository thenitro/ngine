package ngine.string {
    import flash.errors.IllegalOperationError;

    public class StringUtils {
        public function StringUtils() {
            throw new IllegalOperationError("StringUtils is static!")
        };

        public static function stripHTML(pValue:String):String{
            return pValue.replace(/<.*?>/g, "");
        };

        public static function replace(pTarget:String,
                                       pTextToReplace:String,
                                       pNewText:String):String {
            return pTarget.split(pTextToReplace).join(pNewText);
        }
    }
}
