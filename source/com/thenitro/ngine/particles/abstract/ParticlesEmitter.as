package com.thenitro.ngine.particles.abstract {
	import com.thenitro.ngine.pool.IReusable;
	import com.thenitro.ngine.pool.Pool;
	
	import flash.utils.getTimer;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class ParticlesEmitter extends EventDispatcher implements IReusable {
		public static const COMPLETE:String = 'complete_event';
		
		protected static var _pool:Pool = Pool.getInstance();
		
		private var _parameters:Vector.<ParticlesParameters>;
		private var _particles:Vector.<Particle>;
		
		private var _life:uint;
		private var _startTime:int;
		
		private var _disposed:Boolean;
		
		private var _stopped:Boolean;
		private var _started:Boolean;
		
		private var _currentParameters:ParticlesParameters;
		
		public function ParticlesEmitter() {
			_particles    = new Vector.<Particle>();
			_parameters   = new Vector.<ParticlesParameters>();
		};
		
		public function get reflection():Class {
			return ParticlesEmitter;
		};
		
		public function get started():Boolean {
			return _started;
		};
		
		public function get stopped():Boolean {
			return _stopped;
		};
		
		public function get parameters():Vector.<ParticlesParameters> {
			return _parameters;
		};
		
		public function get particles():Vector.<Particle> {
			return _particles;
		};
		
		public function get currentParameters():ParticlesParameters {
			return _currentParameters;
		};
		
		public function nextParameters():void {
			_currentParameters = _parameters.shift() as ParticlesParameters;
			
			if (!_currentParameters) {
				dispatchEventWith(COMPLETE);
				stop();
				
				return;
			}
			
			_life      = _currentParameters.life;
			_startTime = getTimer();
		};
		
		public function createParticles():void {
			var counter:uint;
			
			for (counter = 0; counter < _currentParameters.particlesNum; counter++) {
				_particles.push(createParticle());
			}
		};
		
		public function setUpParticles():void {
			var particle:Particle;
			
			for each (particle in _particles) {
				particle.setup(_currentParameters.x, _currentParameters.y, 
							_currentParameters.bitmap, _currentParameters.life, 
							_currentParameters.vx, _currentParameters.vy,
							_currentParameters.speedX, _currentParameters.speedY, 
							_currentParameters.random);
				
				particle.parameters = _currentParameters;
				particle.emitter    = this;
			}
		};
		
		public function start():void {
			_startTime = getTimer();
			_started   = true;
		};
		
		public function update():void {
			if (!_started) return;
			
			var timePassed:uint = getTimer() - _startTime;
			
			if (timePassed >= _life) {
				nextParameters();
				
				if (!_stopped) {
					setUpParticles();
				}
					
				return;
			}
			
			var particle:Particle;
			
			for each (particle in _particles) {
				particle.vx += particle.speedX;
				particle.vy += _currentParameters.gravity + particle.speedY;
				
				particle.updateScreenPosition();
			}
		};
		
		public function stop():void {
			_stopped = true;
			_started = false;
		};
		
		public function poolPrepare():void {
			clean();
			
			_particles.length  = 0;
			_parameters.length = 0;
			
			_life       = 0;
			
			_stopped = false;
			_started = false;
		};
		
		public function dispose():void {
			clean();
			
			_disposed = true;
			
			_particles  = null;
			_parameters = null;
			_life       = 0;
		};
		
		public function addParameters(pValue:ParticlesParameters):void {
			_parameters.push(pValue);
		};
		
		protected function createParticle():Particle {
			var particle:Particle = _pool.get(Particle) as Particle;
			
			if (!particle) {
				particle = new Particle();
				_pool.allocate(Particle, 1);
			}
			
			return particle;
		};
		
		private function clean():void {
			for each (var particle:Particle in _particles) {
				_pool.put(particle);
			}
			
			for each (var parameters:ParticlesParameters in _parameters) {
				_pool.put(parameters);
			};
		};
	}
}