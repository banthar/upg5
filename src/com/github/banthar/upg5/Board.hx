package com.github.banthar.upg5;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.errors.Error;
import haxe.ds.Vector.Vector;

class Board {

	public var width:Int;

	public var height:Int;
	
	public var data:Vector<Tile>;
	
	public var actors:Array<Actor>;
	
	public var player:Player;
	
	public function new(width, height) {
		this.width = width;
		this.height = height;
		this.data = new Vector(width * height);
		for (i in 0...data.length) {
			data[i] = new Tile();
		}
		actors = new Array();
		this.player = new Player();
		addActor(player);
	}

	public function addActor(actor) {
		actors.push(actor);
	}

	function offset(x, y) {
		if (x < 0 || y < 0 || x >= width || y >= height) {
			throw new Error(x + ", " + y + " is out of bounds");
		}
		return x + y * width;
	}
	
	public function get(x, y) {
		return data[offset(x, y)];
	}

}