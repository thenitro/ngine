package com.thenitro.ngine.particles.abstract {
	import com.thenitro.ngine.pool.Pool;
	
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ParticlesLayer {
		private static const DEFAULT_WIDTH:Number = 480;
		private static var _pool:Pool             = Pool.getInstance();
		
		private static var _textPool:Object = {};
		
		private var _working:Boolean;
		
		private var _id:uint;
		private var _objectsNum:uint;
		
		private var _canvas:Sprite;
		
		private var _emitters:Vector.<ParticlesEmitter>;
		
		public function ParticlesLayer() {	
			_canvas     = new Sprite();
			_emitters   = new Vector.<ParticlesEmitter>();
			_objectsNum = 0;
		};
		
		public function get canvas():Sprite {
			return _canvas;
		};
		
		public function get emitters():Vector.<ParticlesEmitter> {
			return _emitters;
		};
		
		public function get objectsNum():uint {
			return _objectsNum;
		};
		
		public function setID(pValue:uint):void {
			_id = pValue;
		};
		
		public function addObject(pObject:Particle):void {
			_canvas.addChild(pObject);
			_objectsNum++;
		};
		
		public function removeObject(pObject:Particle):void {
			if (!pObject || pObject.parent != _canvas) {
				return;
			}
			
			_canvas.removeChild(pObject);
			_objectsNum--;
		};
		
		public function setAlpha(pValue:Number):void {
			_canvas.alpha = pValue;
		};
		
		public function sort():void {
			return;
		};
		
		public function cull():void {
			return;
		};
		
		public function emit(pEmitter:ParticlesEmitter):void {
			_emitters.push(pEmitter);
			
			pEmitter.nextParameters();
			pEmitter.createParticles();
			pEmitter.setUpParticles();
			pEmitter.start();
			
			for each (var particle:Particle in pEmitter.particles) {
				addObject(particle);
			}
			
			if (!_working) {
				_working = true;
				_canvas.addEventListener(Event.ENTER_FRAME, 
										 enterFrameEventHandler);
			}
			
		};
		
		public function emitText(pLabel:String, pX:Number, pY:Number, pColor:uint, pStageWidth:Number):void {
			var texture:Texture = generateTextTexture(pLabel, pStageWidth);
			
			var speedX:Number =  0.0;
			var speedY:Number = -1.1;
			
			var velocityX:Number =  0.0;
			var velocityY:Number = -3.0;
			
			var parametersA:ParticlesParameters = 
				_pool.get(ParticlesParameters) as ParticlesParameters;
			
			if (!parametersA) {
				parametersA = new ParticlesParameters();
				_pool.allocate(ParticlesParameters, 1);
			}
			
			parametersA.init('text', pX, pY,
				1, texture, 1000, 0, 
				0, 0, 0, 0, false, false, this);
			
			var parametersB:ParticlesParameters = 
				_pool.get(ParticlesParameters) as ParticlesParameters;
			
			if (!parametersB) {
				parametersB = new ParticlesParameters();
				_pool.allocate(ParticlesParameters, 1);
			}
			
			parametersB.init('text', 
				NaN, NaN,
				1, null, 1500, 0.98, speedX, speedY, velocityX, velocityY, 
				false, false, this);
			
			var emitter:ParticlesEmitter = 
				_pool.get(ParticlesEmitter) as ParticlesEmitter;
			
			if (!emitter) {
				emitter = new ParticlesEmitter();
				_pool.allocate(ParticlesEmitter, 1);
			}                               
			
			emitter.addParameters(parametersA);
			emitter.addParameters(parametersB);
			
			emit(emitter);
		};
		
		public function removeEmmiter(pEmitter:ParticlesEmitter):void {
			_emitters.splice(_emitters.indexOf(pEmitter), 1);
			
			for each (var particle:Particle in pEmitter.particles) {
				_canvas.removeChild(particle);
			}
			
			if (_emitters.length == 0) {
				_working = false;
				_canvas.removeEventListener(Event.ENTER_FRAME, 
										    enterFrameEventHandler);
			}
			
			_pool.put(pEmitter);
		};
		
		public function clean():void {
			_working = false;
			
			_canvas.removeEventListener(Event.ENTER_FRAME, 
										enterFrameEventHandler);
			_canvas.removeChildren();
			
			for each (var emitter:ParticlesEmitter in _emitters) {
				_pool.put(emitter);
			}
			
			_emitters.length = 0;
			_objectsNum      = 0;
		};
		
		public function poolPrepare():void {
			clean();
		};
		
		public function dispose():void {
			clean();
			
			_canvas   = null;
			_emitters = null;
		};
		
		private function enterFrameEventHandler():void {
			for each (var emitter:ParticlesEmitter in _emitters) {
				if (emitter.stopped) {
					removeEmmiter(emitter);
					continue;
				}
				
				emitter.update();
			}
		};
		
		private function generateTextTexture(pLabel:String, pStageWidth:Number):Texture {
			if (_textPool[pLabel]) {
				return _textPool[pLabel];
			}
			
			var text:TextField         = new TextField();
				text.autoSize          = TextFieldAutoSize.LEFT;
				text.defaultTextFormat = new TextFormat('Arial Black', 16 * (pStageWidth / DEFAULT_WIDTH), 0x0);
				text.text              = pLabel;
			
			var bd:BitmapData = new BitmapData(text.width, text.height, true, 0x00000000);
				bd.draw(text);
				
			var texture:Texture = Texture.fromBitmapData(bd, false, true); 	
				
			_textPool[pLabel] = texture;
			
			return texture;
		};
	};
};