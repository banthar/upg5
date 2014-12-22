package com.github.banthar.upg5;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.Assets;
using com.github.banthar.upg5.PointUtils;

class BoardView extends Sprite {

	var bitmap:Bitmap;
	
	public var board:Board;
	
	var tiles:BitmapData;
	
	var offset:Point;
	
	var shouldScroll : Bool = false;

	
	public function new(board) {
		super();
		this.board = board;
		this.tiles = Assets.getBitmapData("img/tiles.png");
		this.bitmap = new Bitmap();
		this.offset = this.board.player.getCenter();
		addChild(this.bitmap);
	}
	
	public function init(width, height) {
		this.bitmap.bitmapData = new BitmapData(width, height, false, 0);
		paint();
	}
	
	function sign(n : Float) {
		if (n > 0) return 1;
		if (n < 0) return -1
		else return 0;
	}
	
	
	public function tick() {
		var screenSize = new Point(bitmap.width, bitmap.height);
		var target = this.board.player.getCenter();
	
		if (target.subtract(this.offset).divide(screenSize).length > 0.5 * 0.8) {
			shouldScroll = true;
		}
		if (shouldScroll) {
			var v = target.subtract(offset);
			var scrollSpeed = 8.0;
			if (v.length >= scrollSpeed) {
				v.normalize(scrollSpeed);
				this.offset = this.offset.add(v);
			} else {
				this.offset = target;
				shouldScroll = false;
			}
		}
	}
	
	public function paint() {
		var bitmapData = this.bitmap.bitmapData;
		bitmapData.fillRect(new Rectangle(0, 0, bitmapData.width, bitmapData.height), 0x404040);
		var tileSize = this.board.tileSize;
		var tilePitch = tiles.width / tileSize.x;

		var offsetX = clamp(offset.x - bitmapData.width / 2, 0, board.width * tileSize.x - bitmapData.width);
		var left = Math.floor(offsetX / tileSize.x);
		var right = Math.ceil((offsetX + bitmapData.width) / tileSize.x);
		
		var offsetY = clamp(offset.y - bitmapData.height / 2, 0, board.height * tileSize.y - bitmapData.height);
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
			bitmapData.copyPixels(this.tiles, actor.getUv(board), actor.getXy(board).subtract(new Point(offsetX, offsetY)));
		}
	}
	
	function clamp(x, min, max) {
		return Math.min(max, Math.max(x, min));
	}
	
}