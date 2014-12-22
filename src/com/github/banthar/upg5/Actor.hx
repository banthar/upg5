package com.github.banthar.upg5;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.ds.HashMap;
import haxe.ds.StringMap;
import openfl.utils.Dictionary;
using com.github.banthar.upg5.PointUtils;

class Actor {

	public var position:Point;
		
	public var size:Point;
	
	public var destroyed:Bool;
	
	public function new(position:Point) {
		this.position = position;
		this.destroyed = false;
	}
	
	function round(x:Float, direction:Int) {
		return Math.ceil(x * direction) * direction;
	}
	
	public function getFrame(board:Board):Int {
		throw "getFrame() not implemented";
	}

	public function getTileOffset():Point {
		throw "getTileOffset() not implemented";
	}
	
	public function getUv(board:Board) {
		var offset = getTileOffset();
		var size = this.size;
		var frame = getFrame(board);
		return new Rectangle(offset.x + size.x * frame, offset.y, size.x, size.y);
	}
	
	public function getXy(board:Board) {
		return position;
	}
	
	public function getBounds() {
		return new Rectangle(this.position.x, this.position.y, this.size.x, this.size.y);
	}
	
	static function createActor(type, position, properties):Actor {
		switch( type ) {
			case "Player":
				return new Player(position);
			case "Upgrade":
				return new Upgrade(position, properties.get("upgrade"));
			case "Diamond":
				return new Diamond(position);
		}
		throw "Unknown object type: " + type;
	}
	
	public static function loadFrom(xml:Xml) {
		var position = new Point(Std.parseFloat(xml.get("x")), Std.parseFloat(xml.get("y")));
		var map = new StringMap();
		for (properties in xml.elementsNamed("properties")) {
			for (property in properties.elementsNamed("property")) {
					map.set(property.get("name"), property.get("value"));
			}
		}
		var actor = createActor(xml.get("type"), position, map);
		return actor;
	}
	
	public function tick(board:Board) {
	}
	
	public function destroy() {
		this.destroyed = true;
	}
	
}