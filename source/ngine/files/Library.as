package ngine.files {
    import flash.errors.IllegalOperationError;
    import flash.utils.Dictionary;

    public class Library {
        private static var _instance:Library;
        private static var _allowInstance:Boolean;

        private var _filesByID:Dictionary;
        private var _filesByURL:Dictionary;

        public function Library() {
            if (!_allowInstance) {
                throw new IllegalOperationError('Library is Singleton!');
            }

            _filesByID  = new Dictionary();
            _filesByURL = new Dictionary();
        };

        public static function getInstance():Library {
            if (!_instance) {
                _allowInstance = true;
                _instance      = new Library();
                _allowInstance = false;
            }

            return _instance;
        };

        public function addFile(pFile:TFile):void {
            _filesByID[pFile.id]   = pFile;
            _filesByURL[pFile.url] = pFile;
        };

        public function getByID(pID:String):TFile {
            return _filesByID[pID] as TFile;
        };

        public function getByURL(pURL:String):TFile {
            return _filesByURL[pURL] as TFile;
        };

        public function contains(pID:String):Boolean {
            return _filesByID[pID] || _filesByURL[pID];
        };
    }
}
