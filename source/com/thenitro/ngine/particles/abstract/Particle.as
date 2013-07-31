package com.thenitro.ngine.particles.abstract {
	import com.thenitro.ngine.pool.IReusable;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Particle extends Sprite implements IReusable {
		public var vx:Number;
		public var vy:Number;
				
		private var _emitter:ParticlesEmitter;
		private var _parameters:ParticlesParameters;
		
		private var _speedX:Number;
		private var _speedY:Number;
		
		private var _life:uint;
		
		public function Particle() {
			super();
		};

		public function get reflection():Class {
			return Particle;
		};
		
		public function get emitter():ParticlesEmitter {
			return _emitter;
		}

		public function set emitter(pValue:ParticlesEmitter):void {
			_emitter = pValue;
		};
		
		public function get parameters():ParticlesParameters {
			return _parameters;
		};
		
		public function set parameters(pValue:ParticlesParameters):void {
			_parameters = pValue;
		};
		
		public function get id():uint {
			return 0;
		};
		
		public function get typeID():uint {
			return 0;
		};
		
		public function get layerID():uint {
			return 0;
		};
		
		public function get life():uint {
			return _life;
		};
		
		public function get depth():Number {
			return 0;
		};
		
		public function get speedX():Number {
			return _speedX;
		};
		
		public function get speedY():Number {
			return _speedY;
		};
		
		public function get inViewport():Boolean {
			return true;
		};
		
		public function poolPrepare():void {
			removeChildren(0, -1, true);
			
			_life = 0;
			
			vx = 0;
			vy = 0;
		};
		
		override public function dispose():void {
			super.dispose();
			removeChildren(0, -1, true);
		};
		
		public function setLayerID(pID:uint):void {
			return;
		};
		
		public function setup(pX:Number, pY:Number, 
							  pTexture:Texture, pLife:Number, 
							  pVX:Number, pVY:Number, 
							  pSpeedX:Number, pSpeedY:Number, pRandom:Boolean):void {
			//create an image
			if (pTexture) {
				var image:Image = new Image(pTexture);
				addChild(image);
			}
			
			x = (isNaN(pX)) ? x : pX - image.width  / 2;
			y = (isNaN(pY)) ? y : pY - image.height / 2;
			
			_life = (isNaN(pLife)) ? _life : uint(pLife);
			
			vx = (isNaN(pVX)) ? vx : pVX;
			vy = (isNaN(pVY)) ? vy : pVY;
			
			if (pRandom) {
				var leftOrRight:Number = uint(Math.random() * 2);
				
				vx = (leftOrRight) ? vx : -vx;
				
				
				if (pSpeedX != 0) {
					_speedX = (isNaN(pSpeedX)) ? _speedX : pSpeedX * Math.random();
				} else {
					_speedX = 0;
				}
				
				if (vx < 0) {
					_speedX *= -1;
				}
				
				if (pSpeedY != 0) {
					_speedY = (isNaN(pSpeedY)) ? _speedY : pSpeedY * Math.random();				
				} else {
					_speedY = 0;
				}
			} else {
				if (pSpeedX != 0) {
					_speedX = (isNaN(pSpeedX)) ? _speedX : pSpeedX;
				} else {
					_speedX = 0;
				}
				
				if (pSpeedY != 0) {
					_speedY = (isNaN(pSpeedY)) ? _speedY : pSpeedY;				
				} else {
					_speedY = 0;
				}
			}
		};
		
		public function updateScreenPosition():void {
			x += vx;
			y += vy;
		};
	}
}