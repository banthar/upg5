package com.github.banthar.upg5;
import flash.geom.Rectangle;
import flash.geom.Point;

class Upgrade extends Actor {

	public function new(position:Point) {
		super(position);
		this.size = new Point(16, 16);
	}
	
	override function getUV(board:Board) {
		return new Rectangle(0, 48, 16, 16);
	}

	override function getXY(board:Board) {
		return new Point(this.position.x, this.position.y + Math.sin(board.frame * 0.1) * 3.0);
	}
	
	override function tick(board:Board) {
		if (this.getBounds().intersects(board.player.getBounds())) {
			trace("collected: " + this);
			destroy();
		}
	}
	
}