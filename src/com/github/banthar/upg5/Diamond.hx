package com.github.banthar.upg5;

import openfl.geom.*;

class Diamond extends Collectible {

	var animation:Animation;

	var frame:Int;
	
	var image:Int;
	
	static var SHINE = [
			 new Frame(0, 32),
			 new Frame(1, 4),
			 new Frame(2, 4),
			 new Frame(3, 4),
		];

	static var DULL = [
			 new Frame(0, 0),
		];

		
	public function new(position) {
		super(position);
		this.animation = new Animation();
		this.animation.playNow(DULL);
	}
	
	override function getFrame(board:Board) {
		if (Math.random() < 0.01) {
			animation.playNext(SHINE);
			animation.playNext(DULL);
		}
		return animation.next();
	}
	
	override function getTileOffset() {
		return new Point(0, 32);
	}
	
}