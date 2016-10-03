package;

import haxe.Json;

import kha.Assets;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.Image;
import kha.Scheduler;
import kha.System;

import model.AutoDungeon;
import model.states.BattleState;
import model.states.PassiveWaitState;

class CoreGame extends BaseGame {

	private static inline var GAME_WIDTH:Int = 800;
	private static inline var GAME_HEIGHT:Int = 450;

	private var images:Map<String, Image> = new Map<String, Image>();
	private var game:AutoDungeon = new AutoDungeon(); // TODO: persist data

	public function new()
	{
		super(GAME_WIDTH, GAME_HEIGHT);
		this.loadAssets(function()
		{
			images["background"] = Assets.images.background;
			images["player"] = Assets.images.player;
			images["scenery"] = Assets.images.scenery;
			images["item button"] = Assets.images.button_items;
			images["shop button"] = Assets.images.button_shop;
			images["quit button"] = Assets.images.button_quit;

			images["bat"] = Assets.images.bat;
			images["dragon"] = Assets.images.dragon;
			images["man-eating-flower"] = Assets.images.man_eating_flower;
			images["mosquito"] = Assets.images.mosquito;
			images["spider"] = Assets.images.spider;
			images["town"] = Assets.images.town;
			images["forest"] = Assets.images.forest;

			this.font = Assets.fonts.biryani;

			BattleState.monsterNames = Json.parse(Assets.blobs.monsters_json.toString()).names;			
		});
	}

	override function onUpdate(): Void
	{
		var now = Scheduler.realTime();
		var elapsedSeconds = now - lastUpdateTime;
        this.lastUpdateTime = now;
		
		this.game.update(elapsedSeconds);
	}

	override function onRender(g:Graphics):Void
	{
		this.drawImage(images["background"], 0, 0);
		this.drawImage(images["scenery"], 25, 75);
		this.drawImage(images["player"], 150, 150);
		
		var stateImage = images[this.game.state.imageKey];
		// Center on RHS 
		var x:Int = Std.int((GAME_WIDTH / 2) + ((GAME_WIDTH / 2) - stateImage.width) / 2);
		var y:Int = Std.int((GAME_HEIGHT - stateImage.height) / 2);
		this.drawImage(stateImage, x, y);

		//this.drawText("Location: Merry Meadows", 100, 0, 72);
		this.drawText("Level: 1 (0/250xp)", 25, 325);
		this.drawText("Coins: 0 gold, 0 silver", 25, 350);

		this.drawImage(images["item button"], 575, 350);
		this.drawImage(images["shop button"], 650, 350);
		this.drawImage(images["quit button"], 725, 350);

		this.drawText(this.game.lastMessage, 10, 415);
	}
}