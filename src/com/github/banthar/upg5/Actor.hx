package com.github.banthar.upg5;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.ds.HashMap;
import haxe.ds.StringMap;
import openfl.utils.Dictionary;
using com.github.banthar.upg5.PointUtils;

class Actor {

	public var position:Point;
	
	public var velocity:Point;
	
	public var size:Point;
	
	public var destroyed:Bool;
	
	var hitGround:Bool;
	
	public function new(position:Point) {
		this.position = position;
		this.velocity = new Point();
		this.destroyed = false;
	}
	
	public function move(board:Board, u:Int) {
		var v = 1 - u;
		var stepU = board.tileSize.get(u);
		var stepV = board.tileSize.get(v);

		var velocity = this.velocity.get(u) / stepU;
		var direction = sign(velocity);
		var offset = direction > 0 ? this.size.get(u) : 0.0;
		var position = (this.position.get(u) + offset) / stepU;
		
		var start = round(position, direction);
		var stop = round(position + velocity, direction);
		
		var startV = Math.floor(this.position.get(v) / stepV);
		var endV = Math.ceil((this.position.get(v) + this.size.get(v)) / stepV);

		var i = start;
		while (i != stop) { 
			for (j in startV...endV) {
				var p = i + (direction == 1?0:-1);
				var x = u * j + v * p;
				var y = u * p + v * j;
				if (board.get(x, y).isSolid(direction * v, direction * u)) {
					this.position.set(u, i * stepU - offset);
					this.velocity.set(u, 0);
					if( u == 1 && direction == 1 ) {
						this.hitGround = true;
					}
					return;
				}
			}
			i += direction;
		}
		this.position.set(u, this.position.get(u) + this.velocity.get(u));
	}
	
	function round(x:Float, direction:Int) {
		return Math.ceil(x * direction) * direction;
	}
	
	function sign(x:Float) {
		if (x >= 0) {
			return 1;
		} else {
			return -1;
		}
	}
	
	public function tick(board:Board) {
		this.velocity.y += 0.2;
		hitGround = false;
		for(d in 0...2) {
			this.move(board, d);
		}
	}
	
	public function getUV(board:Board) {
		return new Rectangle();
	}
	
	public function getXY(board:Board) {
		return position;
	}
	
	public function getBounds() {
		return new Rectangle(this.position.x, this.position.y, this.size.x, this.size.y);
	}
	
	static function createActor(type, position, properties):Actor {
		switch( type ) {
			case "Player":
				return new Player(position);
			case "Upgrade":
				return new Upgrade(position, properties.get("upgrade"));
			case "Diamond":
				return new Diamond(position);
		}
		throw "Unknown object type: " + type;
	}
	
	public static function loadFrom(xml:Xml) {
		var position = new Point(Std.parseFloat(xml.get("x")), Std.parseFloat(xml.get("y")));
		var map = new StringMap();
		for (properties in xml.elementsNamed("properties")) {
			for (property in properties.elementsNamed("property")) {
					map.set(property.get("name"), property.get("value"));
			}
		}
		var actor = createActor(xml.get("type"), position, map);
		return actor;
	}
	
	public function destroy() {
		this.destroyed = true;
	}
	
}