package com.thenitro.ngine.textures {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.textures.Texture;
	
	public class SpriteSheetCutter {
		private var _textures:Vector.<Vector.<Texture>>;
		private var _textureByID:Vector.<Texture>;
		private var _createdBitmapData:Vector.<BitmapData>;
		
		private var _tilesNumX:uint;
		private var _tilesNumY:uint;
		
		private var _maxID:uint;
		
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
			
			return _textures[pIndexX][pIndexY];
		};
		
		public function getByID(pID:uint):Texture {
			if (pID >= _maxID) {
				throw new Error("SpriteSheetCutter.getByID(pID) there is no texture with id " + pID);
				return null;
			}
			
			return _textureByID[pID];
		};
		
		public function dispose():void {
			for each (var cell:Vector.<Texture> in _textures) {
				for each (var texture:Texture in cell) {
					texture.dispose();
				}
			}
			
			_textures = null;
			
			for each (var bitmap:BitmapData in _createdBitmapData) {
				bitmap.dispose();
			}
			
			_createdBitmapData = null;
			
			_tilesNumX = 0;
			_tilesNumY = 0;
		};
		
		private function cut(pBitmapData:BitmapData, 
							 pTileWidth:uint, pTileHeight:uint):void {
			_tilesNumX = Math.ceil(pBitmapData.width / pTileHeight);
			_tilesNumY = Math.ceil(pBitmapData.height / pTileHeight);
			
			_maxID = _tilesNumX * _tilesNumY;
			
			_createdBitmapData = new Vector.<BitmapData>(_maxID);
			_textureByID       = new Vector.<Texture>(_maxID);
			
			_textures = new Vector.<Vector.<Texture>>(_tilesNumX);
			
			var textureID:int = 0;
			
			for (var y:uint = 0; y < _tilesNumY; y++) {
				
				var cell:Vector.<Texture> = _textures[x] as Vector.<Texture>;
				
				if (!cell) {
					cell = new Vector.<Texture>(_tilesNumY);
					
				}
				
				for (var x:uint = 0; x < _tilesNumX; x++) {
					var piece:BitmapData = new BitmapData(pTileWidth, pTileHeight, true, 0x00000000);
						piece.copyPixels(pBitmapData, new Rectangle(x * pTileWidth, y * pTileHeight, pTileWidth, pTileHeight), new Point());
					
					_createdBitmapData.push(piece);
					
					var texture:Texture = Texture.fromBitmapData(piece);
					
					cell[y] = texture;
					
					_textureByID[textureID] = texture;
					
					textureID++;
				}
				
				_textures[x] = cell;
				
			}
		};
	};
}