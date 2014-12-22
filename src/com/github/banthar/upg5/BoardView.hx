package com.github.banthar.upg5;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
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
		this.offset = new Point(0, 0);
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
		var center = this.board.player.getCenter();
		var screenCenter = new Point(this.offset.x + screenSize.x / 2, this.offset.y + screenSize.y / 2);
		
		if (center.subtract(screenCenter).divide(screenSize).length > 0.5) {
			shouldScroll = true;
		}
		if (shouldScroll) {
			var target = center.subtract(screenSize.multiply(0.5));
			var v = target.subtract(offset);
			var scrollSpeed = 6.0;
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
			bitmapData.copyPixels(this.tiles, actor.getUV(board), actor.getXY(board).subtract(new Point(offsetX, offsetY)));
		}
	}
	
	function clamp(x, min, max) {
		return Math.min(max, Math.max(x, min));
	}
	
}