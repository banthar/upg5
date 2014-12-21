package com.github.banthar.upg5;
import flash.geom.Point;
import flash.geom.Rectangle;
using com.github.banthar.upg5.PointUtils;

class Actor {

	public var position:Point;
	
	public var velocity:Point;
	
	public var size:Point;
	
	var hitGround:Bool;
	
	public function new() {
		this.position = new Point();
		this.velocity = new Point();
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
		this.velocity.y += 0.1;
		hitGround = false;
		for(d in 0...2) {
			this.move(board, d);
		}
	}
	
	public function getUV() {
		return new Rectangle();
	}
	
	public static function loadFrom(xml:Xml) {
		var actor = new Player();
		actor.position.x = Std.parseFloat(xml.get("x"));
		actor.position.y = Std.parseFloat(xml.get("y"));
		return actor;
	}
	
}