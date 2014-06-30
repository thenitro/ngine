package ngine.string {
    import flash.errors.IllegalOperationError;

    public class Validators {
        public function Validators() {
            throw new IllegalOperationError("Validators is static!");
        };

        public static function validateEmail(pInput:String):Boolean {
            var emailExpression:RegExp = /([a-z0-9._-]+?)@([a-z0-9.-]+)\.([a-z]{2,4})/;
            
            return emailExpression.test(pInput);
        };
    }
}
