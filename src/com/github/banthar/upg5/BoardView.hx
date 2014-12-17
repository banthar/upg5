package com.github.banthar.upg5;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
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
		for (i in 0...board.data.length) {
			var tile = board.data[i];
			var tileId = tile.getId();
			var src = new Rectangle(tileId%tilePitch*tileSize.x, Std.int(tileId/tilePitch)*tileSize.x, tileSize.x, tileSize.y);
			var dst = new Point(i % board.width * tileSize.x, Std.int(i / board.width) * tileSize.y).subtract(offset);
			bitmapData.copyPixels(tiles, src, dst);
		}
		
		offset.x += 1;
		
	}
	
}