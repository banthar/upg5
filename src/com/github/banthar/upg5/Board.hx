package com.github.banthar.upg5;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.errors.Error;
import flash.geom.Point;
import haxe.ds.Vector.Vector;

class Board {

	public var width:Int;

	public var height:Int;
	
	public var data:Vector<Tile>;
	
	public var tileSize:Point;
	
	public var actors:Array<Actor>;
	
	public var player:Player;
	
	public function new(width, height) {
		this.width = width;
		this.height = height;
		this.data = new Vector(width * height);
		this.tileSize =  new Point(16, 16);
		for (i in 0...data.length) {
			data[i] = new Tile();
		}
		actors = new Array();
		this.player = new Player();
		addActor(player);
	}

	public function tick() {
		for (actor in actors) {
			actor.tick(this);
		}
	}
	
	public function addActor(actor) {
		actors.push(actor);
	}

	function isOutOfBounds(x, y) {
		return (x < 0 || y < 0 || x >= width || y >= height);
	}

	function offset(x, y) {
		return x + y * width;
	}
	
	public function get(x, y) {
		if (isOutOfBounds(x, y)) {
			return null;
		} else {
			return data[offset(x, y)];
		}
	}

	public function getTileAt(x:Float, y:Float) {
		return get(Math.floor(x / this.tileSize.x), Math.floor(y / this.tileSize.y));
	}
	
}