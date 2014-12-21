package com.github.banthar.upg5;
import flash.geom.Point;

class PointUtils {

	public static function multiply(p:Point, v:Float)	{
		return new Point(p.x * v, p.y * v);
	}

	public static function mix(p0:Point, p1:Point, a:Float)	{
		var b = 1.0 - a;
		return new Point(p0.x*b + p1.x*a, p0.y*b + p1.y*a);
	}
	
	public static function get(p:Point, d:Int) {
		if (d == 0) {
			return p.x;
		} else if (d == 1) {
			return p.y;
		} else {
			throw "Invalid index: " + d;
		}
	}

	public static function set(p:Point, d:Int, v:Float) {
		if (d == 0) {
			p.x = v;
		} else if (d == 1) {
			p.y = v;
		} else {
			throw "Invalid index: " + d;
		}
	}

	
}