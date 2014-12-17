package com.github.banthar.upg5;
import flash.geom.Point;
import flash.geom.Rectangle;

class Player extends Actor {

	public function new() {
		super();
		this.position = new Point(100, 100);
		this.size = new Point(13 , 32);
	}
	
	override function getUV() {
		return new Rectangle(0, 64, size.x, size.y);
	}
	
}