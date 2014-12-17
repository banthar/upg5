package com.github.banthar.upg5;

class Tile {

	var id:Int;
	
	public function new() {
		id = Math.floor(Math.random()*4);
	}
	
	public function getId() {
		return this.id;
	}
	
}