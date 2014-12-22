package com.github.banthar.upg5;

class Utils {

	public static function sign(x : Float) {
		if (x > 0) { 
			return 1;
		} else if (x < 0) {
			return -1;
		} else {
			return 0;
		}
	}

	public static function normalize(x : Float) {
		if (x > 0) { 
			return 1;
		} else {
			return -1;
		}
	}
}