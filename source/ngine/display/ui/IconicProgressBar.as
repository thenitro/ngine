package ngine.display.ui {
	public final class IconicProgressBar extends UIElement {
		private var _fullIcon:Class;
		private var _emptyIcon:Class;
		
		private var _spacing:Number;
		
		private var _value:int;
		private var _max:int;
		
		private var _objectsCreated:Array;
		
		public function IconicProgressBar() {
			super();
			
			_objectsCreated = [];
		};
		
		override public function get reflection():Class {
			return IconicProgressBar;
		};
		
		override public function draw():void {
			clean();
			
			var prevPosition:Number = 0;
			
			for (var i:int = 0; i < _max; i++) {
				var CurrentClass:Class = _fullIcon;
				
				if (i >= _value) {
					CurrentClass = _emptyIcon;
				}
				
				var currentObject:UIElement = _pool.get(CurrentClass) as UIElement;
				
				if (!currentObject) {
					currentObject = new CurrentClass();
					_pool.allocate(CurrentClass, 1);
				}
				
				currentObject.x = prevPosition + _spacing;
				currentObject.y = 0;

				addChild(currentObject);

				currentObject.draw();
				
				prevPosition = currentObject.x + currentObject.width;
			}
		};
		
		override public function clean():void {
			removeChildren();
			
			for each (var object:UIElement in _objectsCreated) {
				_pool.put(object);
			}
			
			_objectsCreated.length = 0;
		};
		
		override public function dispose():void {
			super.dispose();
			
			_objectsCreated = null;
		};
		
		public function init(pFullIcon:Class, pEmptyIcon:Class, 
							 pSpacing:Number):void {
			_fullIcon  = pFullIcon;
			_emptyIcon = pEmptyIcon;
			
			_spacing = pSpacing;
		};
		
		public function setProgress(pValue:uint, pMax:uint):void {
			_value = pValue;
			_max   = pMax;
		};
	};
}