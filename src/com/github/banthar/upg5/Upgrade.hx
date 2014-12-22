package com.github.banthar.upg5;
import openfl.geom.Rectangle;
import openfl.geom.Point;

class Upgrade extends Collectible {

	var type:String;
	
	public function new(position:Point, type:String) {
		super(position);
		this.type = type;
	}
	
	override function getFrame(board:Board) {
		return 0;
	}
	
	override function getTileOffset() {
		return new Point(0, 48);
	}
}