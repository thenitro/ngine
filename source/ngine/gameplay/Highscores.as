package ngine.gameplay {
	import ngine.storage.LocalStorage;
	
	import starling.events.EventDispatcher;
	
	public final class Highscores extends EventDispatcher {
		public static const NEW_HIGH_SCORE:String = 'new_high_score';
		
		private static var _storage:LocalStorage = LocalStorage.getInstance();
		
		private var _scores:Array;
		
		private var _recordID:String;
		private var _maxItems:uint;
		
		private var _new:Boolean;
		private var _inited:Boolean;
		
		public function Highscores() {
			super();
		};
		
		public function get scores():Array {
			return _scores;
		};
		
		public function init(pRecordID:String, pMaxItems:uint):void {
			if (!_storage.inited) {
				return;
			}
			
			_recordID = pRecordID;
			_maxItems = pMaxItems;
			
			_scores = _storage.load(pRecordID) as Array;
			
			if (!_scores) {
				_scores = [];
				
				_storage.save(pRecordID, _scores);
			}
			
			_scores.sort(Array.NUMERIC | Array.DESCENDING);
			
			if (_scores.length >= _maxItems) {
				_scores.length = _maxItems;
			}
			
			_inited = true;
		};
		
		public function setScore(pScore:Number):void {
			if (!_storage.inited) {
				return;
			}
			
			_scores = _storage.load(_recordID) as Array;
			
			if (_scores.indexOf(pScore) != -1) {
				return;
			}
			
			_scores.unshift(pScore);
			
			if (_scores.length >= _maxItems) {
				_scores.length = _maxItems;
			}
			_scores.sort(Array.NUMERIC | Array.DESCENDING);
			
			_storage.save(_recordID, _scores);
		};
		
		public function start():void {
			_new = true;
		};
		
		public function track(pScore:int):void {
			if (!_inited) {
				return;
			}
			
			if (!_new) {
				return;
			}
			
			if (pScore > _scores[0]) {
				_new = false;
				
				dispatchEventWith(NEW_HIGH_SCORE, false, pScore);
			}
		};
		
		public function stop():void {
			
		};
	};
}