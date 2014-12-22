package com.github.banthar.upg5;
import com.github.banthar.upg5.Board;
import haxe.ds.StringMap;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
using com.github.banthar.upg5.PointUtils;

class Player extends Mobile {

	var jumpLevel:Int = 1;
	
	var leftPressed:Bool;

	var rightPressed:Bool;
	
	var jumpsLeft:Int;
	
	var frame:Int;
	
	var sliding:Bool;

	var view:PlayerView;
	
	var upgrades:StringMap<Bool>;
	
	public function new(position:Point) {
		super(position);
		this.size = new Point(13 , 25);
		this.frame = 0;
		this.view = new PlayerView();
		this.upgrades = new StringMap();
	}
	
	override function getFrame(board:Board) {
		return this.view.next();
	}
	
	override function getTileOffset() {
		return new Point(0, 64);
	}
	
	public function onKeyDown(keyCode) {
		switch(keyCode) {
			case 37,65:
				leftPressed = true;
			case 38, 87:
				jump();
			case 39,68:
				rightPressed = true;
		}
	}
	
	function jump() {
		if (jumpsLeft > 0 && !dead) {
			jumpsLeft--;
			this.velocity.y = -5.5;
		}
	}
	
	override function tick(board:Board) {
		var v = (leftPressed? -1.0:0.0) + (rightPressed?1.0:0.0);	
		if (dead) v = 0;
		this.velocity.x = v * 1.5;
			
		if (this.hitGround) {
			jumpsLeft = jumpLevel;
			frame++;
		}
		super.tick(board);
		this.view.setVelocity(this.velocity);
	}
	
	public function onKeyUp(keyCode) {
		switch(keyCode) {
			case 37,65:
				leftPressed = false;
			case 39,68:
				rightPressed = false;
		}
	}
	
	public function getCenter() {
		return this.position.add(this.size.multiply(0.5));
	}

	public function addUpgrade(type) {
		this.upgrades.set(type, true);
	}

}