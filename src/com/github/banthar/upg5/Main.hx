package com.github.banthar.upg5;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

class Main extends Sprite {

	var boardView:BoardView;
	
	public function new() {
		super();	
		var board = new Board(32, 32);
		this.boardView = new BoardView(board);
		addEventListener(Event.ADDED_TO_STAGE, added);
		addChild(boardView);
		addEventListener(Event.ENTER_FRAME, function(_) {
				boardView.paint();
			});
	}

	function resize(_) {
		var scale = 2;
		scaleX = scale;
		scaleY = scale;
		boardView.init(Math.ceil(stage.stageWidth/scale), Math.ceil(stage.stageHeight/scale));
	}
	
	function added(e) {
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		resize(null);
	}
	
	public static function main() {
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
		Lib.current.addChild(new FpsCounter());
	}
}
