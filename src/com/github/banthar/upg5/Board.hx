package com.github.banthar.upg5;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.errors.Error;
import flash.geom.Point;
import flash.utils.Endian;
import haxe.crypto.BaseCode;
import haxe.ds.Vector.Vector;
import haxe.io.Bytes;
import haxe.io.BytesData;
import haxe.io.BytesInput;
import haxe.io.Input;
import haxe.xml.Parser;
import openfl.Assets;

class Board {

	public var width:Int;

	public var height:Int;
	
	public var data:Vector<Tile>;
	
	public var tileSize:Point;
	
	public var actors:Array<Actor>;
	
	public var player:Player;
	
	public function new(width, height, bytes:Input) {
		this.width = width;
		this.height = height;
		this.data = new Vector(width * height);
		this.tileSize =  new Point(16, 16);
		bytes.bigEndian = false;
		for (i in 0...data.length) {
			data[i] = Tile.fromId(bytes.readInt32());
		}
		actors = new Array();
	}
	
	public function tick() {
		for (actor in actors) {
			actor.tick(this);
		}
	}
	
	public function addActor(actor) {
		if (Std.is(actor, Player)) {
			player = actor;
		}
		actors.push(actor);
	}

	function isOutOfBounds(x, y) {
		return (x < 0 || y < 0 || x >= width || y >= height);
	}

	function offset(x, y) {
		return x + y * width;
	}
	
	public function get(x, y) {
		if (isOutOfBounds(x, y)) {
			return null;
		} else {
			return data[offset(x, y)];
		}
	}

	public function set(x, y, tile) {
		if (isOutOfBounds(x, y)) {
			throw "Index out of bounds: " + x + ", " + y;
		} else {
			data[offset(x, y)] = tile;
		}
	}
	
	public function getTileAt(x:Float, y:Float) {
		return get(Math.floor(x / this.tileSize.x), Math.floor(y / this.tileSize.y));
	}
	
	static function decode(base64:String) {
		var length = base64.indexOf('=');
		var stripped = base64.substr(0, length);
		var base = Bytes.ofString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/");
		return new BaseCode(base).decodeBytes(Bytes.ofString(stripped));
	}
	
	public static function loadFrom(xml:String) {
		var map = Xml.parse(xml).elementsNamed("map").next();
		var layer = map.elementsNamed("layer").next();
		var width = Std.parseInt(layer.get("width"));
		var height = Std.parseInt(layer.get("height"));
		var data = decode(StringTools.trim(layer.elementsNamed("data").next().firstChild().nodeValue));
		var board = new Board(width, height, new BytesInput(data));
		var objectGroup = map.elementsNamed("objectgroup").next();
		for ( object in objectGroup.elements()) {
			var actor = Actor.loadFrom(object);
			board.addActor(actor);
		}
		return board;
	}
}