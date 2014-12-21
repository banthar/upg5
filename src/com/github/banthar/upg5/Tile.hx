package com.github.banthar.upg5;

class Tile {

	var id:Int;
	
	public function new(id) {
		this.id = id;
	}
	
	public function getId() {
		return this.id - 1;
	}
	
	public function isSolid(signX:Float, signY:Float) {
		switch(this.id) {
			case 0:
				return false;
			case 5:
				return signX==0 && signY>0;
			default:
				return true;
		}
	}
	
	public static function fromId(id) {
		return new Tile(id);
	}
	
}