package com.github.banthar.upg5;

class Animation {
	
	var keyFrames:Array<Frame>;
	
	var frame:Int;

	var queue:Array<Array<Frame>>;

	public function new() {
		this.frame = 0;
		this.queue = [];
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
		if (queue.length > 0) {
			this.keyFrames = queue.shift();
		}
		return this.keyFrames[0].frame;
	}
	
	public function playNext(frames) {
		this.queue.push(frames);
	}
	
		
	public function playNow(frames) {
		this.queue = [];
		this.keyFrames = frames;
		this.frame = 0;
	}
	
}