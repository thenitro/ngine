package com.thenitro.ngine.particles.abstract {
	import com.thenitro.ngine.pool.IReusable;
	
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	
	public class ParticlesParameters implements IReusable {
		private var _disposed:Boolean;
		
		private var _x:Number;
		private var _y:Number;
		
		private var _life:uint;
		private var _particlesNum:uint;
		
		private var _bitmap:Texture;
		
		private var _gravity:Number;
		
		private var _speedX:Number;
		private var _speedY:Number;
		
		private var _vx:Number;
		private var _vy:Number;
		
		private var _type:String;
		
		private var _useMouse:Boolean;
		private var _random:Boolean;
		
		private var _layer:ParticlesLayer;
		
		public function ParticlesParameters() {
			
		};
		
		public function init(pType:String, pX:Number, pY:Number, 
							 pParticlesNum:uint, pBitmap:Texture, 
							 pLife:uint, pGravity:Number, 
							 pSpeedX:Number, pSpeedY:Number, 
							 pVX:Number, pVY:Number, 
							 pUseMouse:Boolean, pRandom:Boolean, 
							 pLayer:ParticlesLayer):void {
			_x = pX;
			_y = pY;
			
			_life         = pLife;
			_particlesNum = pParticlesNum;
			
			_gravity = pGravity;
			
			_speedX = pSpeedX;
			_speedY = pSpeedY;
			
			_vx = pVX;
			_vy = pVY;
			
			_bitmap = pBitmap;
			_type = pType;
			
			_useMouse = pUseMouse;
			_random   = pRandom;
			
			_layer = pLayer;
		};
		
		public function get type():String {
			return _type;
		};
		
		public function get reflection():Class {
			return ParticlesParameters;
		};
		
		public function get disposed():Boolean {
			return _disposed;
		};
		
		public function get x():Number {
			return _x;
		};
		
		public function get y():Number {
			return _y;
		};
		
		public function get particlesNum():int {
			return _particlesNum;
		};
		
		public function get bitmap():Texture {
			return _bitmap;
		};
		
		public function get life():uint {
			return _life;
		};
	
		public function get gravity():Number {
			return _gravity;
		};
		
		public function get speedX():Number {
			return _speedX;
		};
		
		public function get speedY():Number {
			return _speedY;
		};
		
		public function get vx():Number {
			return _vx;
		};
		
		public function get vy():Number {
			return _vy;
		};
		
		public function get random():Boolean {
			return _random;
		};
		
		public function get layer():ParticlesLayer {
			return _layer;
		};
		
		public function poolPrepare():void {
			_x = 0;
			_y = 0;
			
			_life = 0;
			
			_gravity = 0;
			
			_speedX = 0;
			_speedY = 0;
			
			_vx = 0;
			_vy = 0;
			
			_particlesNum = 0;
			
			_bitmap = null;
			_type   = null;
			_layer  = null;
		};
		
		public function dispose():void {
			_disposed = true;
			_bitmap   = null;
			_layer    = null;
		};
	}
}