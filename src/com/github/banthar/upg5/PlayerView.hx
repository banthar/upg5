package com.github.banthar.upg5;
import openfl.geom.Point;

class PlayerView {

	static var STAND = [
		 new Frame(0, 0),
	];

	static var TURN_RIGHT = [
		 new Frame(1, 2),
	];

	static var WALK_RIGHT = [
		 new Frame(6, 4),
		 new Frame(7, 4),
		 new Frame(8, 4),
		 new Frame(9, 4),
	];
	
	static var JUMP_RIGHT = [
		 new Frame(6, 0),
	];
	
	static var TURN_LEFT = [
		 new Frame(5, 2),
	];
	
	static var WALK_LEFT = [
		 new Frame(10, 4),
		 new Frame(11, 4),
		 new Frame(12, 4),
		 new Frame(13, 4),
	];

	static var JUMP_LEFT = [
		 new Frame(10, 0),
	];

	var animation:Animation;
	
	var velocity:Point;
	
	public function new() {
		this.animation = new Animation();
		this.velocity = new Point();
		this.animation.playNow(STAND);
	}

	public function setVelocity(newVelocity:Point) {
		if (this.velocity.y == 0.0) {
			if(velocity.x * newVelocity.x <= 0.0) {
				if (newVelocity.x > 0) {
					this.animation.playNow(TURN_RIGHT);
					this.animation.playNext(WALK_RIGHT);
				} else if (newVelocity.x < 0) {
					this.animation.playNow(TURN_LEFT);
					this.animation.playNext(WALK_LEFT);
				} else if (this.velocity.x != 0.0 && newVelocity.x == 0.0) {
					this.animation.playNow(STAND);
					if (this.velocity.x > 0) {
						this.animation.playNow(TURN_RIGHT);
					} else if (this.velocity.x < 0) {
						this.animation.playNow(TURN_LEFT);
					}
					this.animation.playNext(STAND);
				}
			}
		} else {
			if (newVelocity.x > 0) {
				this.animation.playNow(JUMP_RIGHT);
			} else if (newVelocity.x < 0) {
				this.animation.playNow(JUMP_LEFT);
			} else if (newVelocity.x  == 0) {
				this.animation.playNow(STAND);
			}
		}
		this.velocity = newVelocity.clone();
	}
	
	public function next() {
		return this.animation.next();
	}
	
}