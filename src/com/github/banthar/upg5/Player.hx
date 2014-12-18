package com.github.banthar.upg5;
import com.github.banthar.upg5.Board;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

class Player extends Actor {

	var leftPressed:Bool;

	var rightPressed:Bool;

	var jumpPressed:Bool;

	public function new() {
		super();
		this.position = new Point(50, 50);
		this.size = new Point(13 , 25);
	}
	
	override function getUV() {
		return new Rectangle(0, 64, size.x, size.y);
	}
	
	public function onKeyDown(keyCode) {
		switch(keyCode) {
			case 37,65:
				leftPressed = true;
			case 38,87:
				jumpPressed = true;
			case 39,68:
				rightPressed = true;
		}
	}
	
	override function tick(board:Board) {
		var v = (leftPressed?-1.0:0.0) + (rightPressed?1.0:0.0);
		this.velocity.x = v;
		
		if (jumpPressed && hitGround) {
			this.velocity.y = -4.0;
		}
		super.tick(board);
	}
	
	public function onKeyUp(keyCode) {
		switch(keyCode) {
			case 37,65:
				leftPressed = false;
			case 38,87:
				jumpPressed = false;
			case 39,68:
				rightPressed = false;
		}
	}
}