package ngine.string {

        [Inline]
        public function capitalizeFirstLetter(pString:String):String {
            var char:String = pString.charAt(0).toUpperCase();

            return char + pString.substr(1, pString.length - 1);
        }
}
