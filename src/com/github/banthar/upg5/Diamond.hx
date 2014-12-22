package com.github.banthar.upg5;

import openfl.geom.*;

class Diamond extends Collectible {

	var animation:Animation;

	var frame:Int;
	
	var image:Int;
	
	public function new(position) {
		super(position);

		this.animation = new Animation([
			 new Frame(0, 32),
			 new Frame(1, 4),
			 new Frame(2, 4),
			 new Frame(3, 4),
		]);
	}

	override function getFrame(board:Board) {
		return animation.next();
	}
	
	override function getTileOffset() {
		return new Point(0, 32);
	}
	
}