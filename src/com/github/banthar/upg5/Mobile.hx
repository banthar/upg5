package com.github.banthar.upg5;

using com.github.banthar.upg5.PointUtils;
import openfl.geom.Point;

class Mobile extends Actor {

	public var velocity:Point;

	var hitGround:Bool;

	var isSliding:Bool;

	var dead:Bool = false;
	
	public function new(position:Point) {
		super(position);
		this.velocity = new Point();
	}

	public function move(board:Board, u:Int) {
		var v = 1 - u;
		var stepU = board.tileSize.get(u);
		var stepV = board.tileSize.get(v);

		var velocity = this.velocity.get(u) / stepU;
		var direction = Utils.normalize(velocity);
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
				if (board.get(x, y).interact(direction * v, direction * u, this)) {
					this.position.set(u, i * stepU - offset);
					this.velocity.set(u, 0);
					if ( u == 1 ) {
						if(direction == 1) {
							this.hitGround = true;
						}
					} else if ( u == 0 ) {
						this.isSliding = true;
						if(this.velocity.y > 0) {
							this.velocity.y *= getFriction();
						}
					}
					return;
				}
			}
			i += direction;
		}
		this.position.set(u, this.position.get(u) + this.velocity.get(u));
	}
	public function die() {
		dead = true;
	}
	
	override public function tick(board:Board) {
		super.tick(board);
		this.velocity.y += 0.2;
		hitGround = false;
		isSliding = false;
		for(d in 0...2) {
			this.move(board, d);
		}
	}
	
	public function getFriction() {
		return 0.5;
	}
}