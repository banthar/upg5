package com.github.banthar.upg5;
import flash.geom.Point;
import flash.geom.Rectangle;

class Actor {

	public var position:Point;
	
	public var velocity:Point;
	
	public var size:Point;
	
	public function new() {
		this.position = new Point();
		this.velocity = new Point();
	}
	
	public function moveX(board:Board) {
		var stepX = board.tileSize.x;
		var signX = sign(this.velocity.x);
		var nextX = if( signX > 0.0 ) {
				Math.ceil((this.position.x + this.size.x) / stepX) * stepX - this.size.x;
			} else {
				Math.floor(this.position.x / stepX) * stepX;
			}
		var endX = this.position.x + this.velocity.x;
		while (true) {
			if (nextX * signX >= endX * signX) {
				nextX = endX;
			}
			var lastX = this.position.x;
			this.position.x = nextX;
			if (collides(board)) {
				this.position.x = lastX;
				this.velocity.x = 0.0;
				break;
			}
			if (nextX == endX) {
				break;
			}
			nextX += stepX * signX;
		}
	}
	
	public function moveY(board:Board) {
		var stepY = board.tileSize.y;
		var signY = sign(this.velocity.y);
		var nextY = if( signY > 0.0 ) {
				Math.ceil((this.position.y + this.size.y) / stepY) * stepY - this.size.y;
			} else {
				Math.floor(this.position.y / stepY) * stepY;
			}
		var endY = this.position.y + this.velocity.y;
		while (true) {
			if (nextY * signY >= endY * signY) {
				nextY = endY;
			}
			var lastY = this.position.y;
			this.position.y = nextY;
			if (collides(board)) {
				this.position.y = lastY;
				this.velocity.y = 0.0;
				break;
			}
			if (nextY == endY) {
				break;
			}
			nextY += stepY * signY;
		}
	}
	
	public function tick(board:Board) {
		this.velocity.y += 0.1;
		
		this.moveX(board);
		this.moveY(board);
		
		if (this.position.x > 800) {
			this.position.x = 0;
		}
	}
	
	function collides(board:Board) {
		for (x in Math.floor(this.position.x / board.tileSize.x) ... Math.ceil((this.position.x + this.size.x) / board.tileSize.x)) {
			for (y in Math.floor(this.position.y / board.tileSize.y) ... Math.ceil((this.position.y + this.size.y) / board.tileSize.y)) {
				if (board.get(x, y).isSolid()) {
					return true;
				}
			}			
		}
		return false;
	}
	
	function sign(x) {
		if (x < 0.0) {
			return -1.0;
		} else {
			return 1.0;
		}
	}
	
	public function getUV() {
		return new Rectangle();
	}
}