package com.thenitro.ngine.textures {
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class SpriteSheetCutter {
		private var _textures:Vector.<Vector.<String>>;
		
		private var _tilesNumX:uint;
		private var _tilesNumY:uint;
		
		private var _maxID:uint;
		
		private var _atlas:TextureAtlas;
		
		public function SpriteSheetCutter(pBitmapData:BitmapData, 
										  pTileWidth:uint, pTileHeight:uint) {
			if (!pBitmapData) {
				throw new Error("SpriteSheetCutter: BitmapData is empty!");
				return;
			}
			
			cut(pBitmapData, pTileWidth, pTileHeight);
		};
		
		public function get maxID():uint {
			return _maxID;
		};
		
		public function getByIndex(pIndexX:uint, pIndexY:uint):Texture {
			if (pIndexX >= _tilesNumX || pIndexY >= _tilesNumY) {
				throw new Error("SpriteSheetCutter.getByIndex(pIndexX, pIndexY): index " + pIndexX + " " + pIndexY + " is out of range!");
				return null;
			}
			
			trace("SpriteSheetCutter.getByIndex(pIndexX, pIndexY)", pIndexX, pIndexY);
			trace("SpriteSheetCutter.getByIndex(pIndexX, pIndexY)", _textures.length, _textures[pIndexY].length);
			
			return _atlas.getTexture(_textures[pIndexY][pIndexX]);
		};
		
		public function getByID(pID:uint):Texture {
			if (pID >= _maxID) {
				throw new Error("SpriteSheetCutter.getByID(pID) there is no texture with id " + pID);
				return null;
			}
			
			//return _textureByID[pID];
			return _atlas.getTexture(pID.toString());
		};
		
		public function dispose():void {
			_textures = null;
			
			_atlas.dispose();
			_atlas = null;
			
			_tilesNumX = 0;
			_tilesNumY = 0;
		};
		
		private function cut(pBitmapData:BitmapData, 
							 pTileWidth:uint, pTileHeight:uint):void {
			_tilesNumX = Math.round(pBitmapData.width / pTileHeight);
			_tilesNumY = Math.round(pBitmapData.height / pTileHeight);
			
			trace("SpriteSheetCutter.cut(pBitmapData, pTileWidth, pTileHeight)", _tilesNumX, _tilesNumY);
			
			_maxID = _tilesNumX * _tilesNumY;
			
			_textures = new Vector.<Vector.<String>>(_tilesNumX);
			
			var textureID:int = 0;
			var texuresText:String = '';
			
			for (var y:uint = 0; y < _tilesNumY; y++) {				
				for (var x:uint = 0; x < _tilesNumX; x++) {
					var cell:Vector.<String> = _textures[x] as Vector.<String>;
					
					if (!cell) {
						cell = new Vector.<String>(_tilesNumY);
						_textures[x] = cell;
					}
					
					texuresText += '<SubTexture name="' + textureID + '" ' + 
											'x="' + x * pTileWidth + 
											'" y="' + y * pTileHeight + 
											'" width="' + pTileWidth + 
											'" height="' + pTileHeight + 
											'" frameX="0" frameY="0" ' +
											'frameWidth="' + pTileHeight + 
											'" frameHeight="' + pTileHeight + 
											'"/>';
					
					cell[y] = textureID.toString();
					
					textureID++;
				}
			}
			
			_atlas = new TextureAtlas(Texture.fromBitmapData(pBitmapData),
									  new XML('<TextureAtlas imagePath="dynamic.png">' + 
										  	  texuresText + "</TextureAtlas>"));
		};
	};
}