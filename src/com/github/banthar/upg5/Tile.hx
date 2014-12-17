package com.github.banthar.upg5;

class Tile {

	var id:Int;
	
	public function new() {
		if(Math.random()>0.85) {
			id = Math.floor(Math.random() * 4);
		}
	}
	
	public function getId() {
		return this.id;
	}
	
	public function isSolid() {
		return this.id != 0;
	}
	
}