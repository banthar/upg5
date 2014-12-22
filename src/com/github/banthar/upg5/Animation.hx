package com.github.banthar.upg5;

class Animation {
	
	var keyFrames:Array<Frame>;
	
	var frame:Int;
	
	public function new(keyFrames) {
		this.keyFrames = keyFrames;
		this.frame = 0;
		
	}
	
	public function next():Int {
		var i = 0;
		for (keyFrame in this.keyFrames) {
			i += keyFrame.delay;
			if (i >= this.frame) {
				this.frame++;
				return keyFrame.frame;
			}
		}
		this.frame = 0;
		return this.keyFrames[0].frame;
	}
	
}