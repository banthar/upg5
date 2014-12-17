package com.github.banthar.upg5;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import openfl.Assets;

class BoardView extends Sprite {

	var bitmap:Bitmap;
	
	var board:Board;
	
	var tiles:BitmapData;
	
	var tileSize:Point;
	
	var offset:Point;
	
	public function new(board) {
		super();
		this.board = board;
		this.tileSize =  new Point(16, 16);
		this.tiles = Assets.getBitmapData("img/tiles.png");
		this.bitmap = new Bitmap();
		this.offset = new Point(0, 0);
		addChild(this.bitmap);
	}
	
	public function init(width, height) {
		this.bitmap.bitmapData = new BitmapData(width, height, false, 0);
		paint();
	}
	
	public function paint() {
		var bitmapData = this.bitmap.bitmapData;
		bitmapData.fillRect(new Rectangle(0, 0, bitmapData.width, bitmapData.height), 0x404040);

		var tilePitch = tiles.width / this.tileSize.x;

		var offsetX = clamp(offset.x, 0, board.width * tileSize.x - bitmapData.width);
		var left = Math.floor(offsetX / tileSize.x);
		var right = Math.ceil((offsetX + bitmapData.width) / tileSize.x);
		
		var offsetY = clamp(offset.y, 0, board.height * tileSize.y - bitmapData.height);
		var top = Math.floor(offsetY / tileSize.y);
		var bottom = Math.ceil((offsetY + bitmapData.height) / tileSize.y);
		
		for(y in top...bottom){
			for (x in left...right) {
				var tile = board.get(x,y);
				var tileId = tile.getId();
				var src = new Rectangle(tileId%tilePitch*tileSize.x, Std.int(tileId/tilePitch)*tileSize.x, tileSize.x, tileSize.y);
				var dst = new Point(x * tileSize.x - offsetX, y * tileSize.y - offsetY);
				bitmapData.copyPixels(this.tiles, src, dst);
			}
		}
		
		for (actor in this.board.actors) {
			bitmapData.copyPixels(this.tiles, actor.getUV(), actor.position);
		}
	}
	
	function clamp(x, min, max) {
		return Math.min(max, Math.max(x, min));
	}
	
}