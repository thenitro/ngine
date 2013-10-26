package ngine.sprites {
	import com.emibap.textureAtlas.DynamicAtlas;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import starling.display.Stage;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class DynamicTexture {
		private var _textures:Object;
		private var _scale:Number;
		
		public function DynamicTexture() {
			_textures = {};
			
		};
		
		public function init(pStage:Stage, 
							 pReferenceWidth:Number, pReferenceHeight:Number):void {
			var scaleX:Number = pStage.stageWidth  / pReferenceWidth;
			var scaleY:Number = pStage.stageHeight / pReferenceHeight;
			
			_scale = Math.min(scaleX, scaleY);
			
			trace("DynamicTexture.init(pStage, pReferenceWidth, pReferenceHeight)", _scale);
		};
		
		public function parse():void {
			
		};
		
		public function getTexture(pID:String):Texture {
			return _textures[pID] as Texture;
		};
		
		protected function convertToTextures(pTarget:Sprite):void {
			var i:int;
			var child:DisplayObject;
			
			for (i = 0; i < pTarget.numChildren; i++) {
				child = pTarget.getChildAt(i);
				
				child.width  *= _scale;
				child.height *= _scale;
				
				child.width  = child.width  > 2048 ? 2048 : child.width;
				child.height = child.height > 2048 ? 2048 : child.height;
			}
			
			var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(pTarget, 1, 0, true, true);
			
			for (i = 0; i < pTarget.numChildren; i++) {
				child = pTarget.getChildAt(i);
				
				_textures[child.name] = atlas.getTextures(child.name)[0];
			}
		};
	};
}