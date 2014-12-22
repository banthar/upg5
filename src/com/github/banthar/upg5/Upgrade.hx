package com.github.banthar.upg5;
import flash.geom.Rectangle;
import flash.geom.Point;

class Upgrade extends Collectible {

	var type:String;
	
	public function new(position:Point, type:String) {
		super(position);
		this.type = type;
	}
	
	override function getUv(board:Board) {
		return new Rectangle(0, 48, 16, 16);
	}

	
}