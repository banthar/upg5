package com.github.banthar.upg5;
import openfl.geom.Rectangle;

class Diamond extends Collectible {

	public function new(position) {
		super(position);
	}

	override function getUv(board:Board) {
		return new Rectangle(0, 32, 16, 16);
	}
}