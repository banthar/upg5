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
	
}