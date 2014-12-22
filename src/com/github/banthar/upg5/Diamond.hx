package com.github.banthar.upg5;

import openfl.geom.*;

class Diamond extends Collectible {

	public function new(position) {
		super(position);
	}

	override function getFrame(board:Board) {
		return Math.floor(board.frame / 4) % 4;
	}
	
	override function getTileOffset() {
		return new Point(0, 32);
	}
	
}