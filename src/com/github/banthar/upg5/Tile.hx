package com.github.banthar.upg5;

class Tile {

	var id:Int;
	
	public function new(id) {
		this.id = id;
	}
	
	public function getId() {
		return this.id - 1;
	}
	
	public function isSolid() {
		return this.id != 0;
	}
	
}