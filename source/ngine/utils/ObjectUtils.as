package ngine.utils {
    import flash.errors.IllegalOperationError;

    public class ObjectUtils {

        public function ObjectUtils() {
            throw new IllegalOperationError('ObjectUtils is static!')
        };

        public static function getFirstItem(pObject:Object):Object {
            for each (var item:Object in pObject) {
                return item;
            }

            return null;
        };

        public static function repr(pObject:Object, pDeep:Boolean = false):void {
            var makeLines:Function = function(pCount:int):String {
                if (!pCount) {
                    return '';
                }

                if (pCount == 1) {
                    return '-';
                }

                var result:String = '';

                for (var i:int = 0; i < pCount; i++) {
                    result += '-'
                }

                return result;
            };

            var repro:Function = function(pObject:Object, pDeep:Boolean = false, pCount:int = 0):void {
                for (var id:Object in pObject) {
                    var data:Object = pObject[id];

                    trace('ObjectUtils.repr:', makeLines(pCount), id, pObject[id]);

                    if (data is int || data is Number || data is String || data is Boolean) {
                        continue;
                    }

                    if (pDeep) {
                        repro(pObject[id], pDeep, pCount + 1);
                    }
                }
            };

            repro(pObject, pDeep);
        };
    }
}
