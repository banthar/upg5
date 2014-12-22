package com.github.banthar.upg5;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import openfl.Assets;

class Main extends Sprite {

	var boardView:BoardView;

	public function new() {
		super();	
		var board = Board.loadFrom(Assets.getText("levels/level0.tmx"));
		this.boardView = new BoardView(board);
		addEventListener(Event.ADDED_TO_STAGE, added);
		addChild(boardView);
		addEventListener(Event.ENTER_FRAME, function(_) {
				board.tick();
				boardView.tick();
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
		stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e) {
			boardView.board.player.onKeyDown(e.keyCode);
		});
		stage.addEventListener(KeyboardEvent.KEY_UP, function(e) {
			boardView.board.player.onKeyUp(e.keyCode);
		});		resize(null);
	}
	
	public static function main() {
		Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
		Lib.current.addChild(new FpsCounter());
	}
}
