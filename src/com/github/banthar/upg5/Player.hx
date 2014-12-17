package com.github.banthar.upg5;
import flash.events.KeyboardEvent;
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
	
	public function onKeyDown(keyCode) {
		switch(keyCode) {
			case 37,65:
				this.velocity.x = -1.0;
			case 38,87:
				this.velocity.y = -4.0;
			case 39,68:
				this.velocity.x = 1.0;
		}
	}
	
	public function onKeyUp(keyCode) {
		switch(keyCode) {
			case 37,65:
				this.velocity.x = 0.0;
			case 39,68:
				this.velocity.x = 0.0;
		}
	}
}