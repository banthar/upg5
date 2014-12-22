package com.github.banthar.upg5;

class Tile {

	var id:Int;
	
	public function new(id) {
		this.id = id;
	}
	
	public function getId() {
		return this.id - 1;
	}
	
	public function interact(signX:Float, signY:Float, mobile : Mobile) {
		trace(this.id);
		switch(this.id) {
			case 0:
				return false;
			case 5:
				return signX==0 && signY>0;
			case 69:
				if (signY > 0) {
					mobile.destroy();	
				}
				return false;
			default:
				return true;
		}
	}
	
	public static function fromId(id) {
		return new Tile(id);
	}
	
}