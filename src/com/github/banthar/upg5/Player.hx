package com.github.banthar.upg5;
import flash.geom.Rectangle;

class Player extends Actor {

	public function new() {
		super();
	}
	
	override function getUV() {
		return new Rectangle(0, 64, 13, 32);
	}
	
}