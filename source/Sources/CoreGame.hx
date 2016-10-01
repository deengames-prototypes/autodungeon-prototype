package;

import kha.Assets;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.Image;
import kha.Scheduler;
import kha.System;

import model.AutoDungeon;

class CoreGame extends BaseGame {

	private var images:Map<String, Image> = new Map<String, Image>();
	private var game:AutoDungeon = new AutoDungeon(); // TODO: persist data

	public function new()
	{
		super(800, 450);
		this.loadAssets(function()
		{
			images["background"] = Assets.images.background;
			images["player"] = Assets.images.player;
			images["scenery"] = Assets.images.scenery;
			images["monster"] = Assets.images.monster;
			images["item button"] = Assets.images.button_items;
			images["shop button"] = Assets.images.button_shop;
			images["quit button"] = Assets.images.button_quit;
			this.font = Assets.fonts.biryani;
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
		this.drawImage(images["monster"], 550, 150);

		this.drawText("Location: Merry Meadows", 100, 0, 72);
		this.drawText("Level: 1 (0/250xp)", 25, 325);
		this.drawText("Coins: 0 gold, 0 silver", 25, 350);

		this.drawImage(images["item button"], 575, 350);
		this.drawImage(images["shop button"], 650, 350);
		this.drawImage(images["quit button"], 725, 350);

		this.drawText(this.game.lastMessage, 10, 415);
	}
}