package com.github.banthar.upg5;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.text.TextField;


class FpsCounter extends TextField {

	var lastTick = 0;
	
	public function new() {
		super();
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function onEnterFrame(_) {
		var currentTick = Lib.getTimer();
		var frameTicks = (currentTick - lastTick);
		this.text = frameTicks + "ms";
		if (frameTicks > 1000/(stage.frameRate-1)) {
			this.textColor = 0xff0000;
		} else {
			this.textColor = 0x00ff00;
		}
		lastTick = currentTick;
	}
	
}