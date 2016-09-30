package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
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

	override function update(): Void
	{
		super.update();
		var now = Scheduler.realTime();
		var elapsedSeconds = now - lastUpdateTime;
        this.lastUpdateTime = now;
		
		this.game.update(elapsedSeconds);
	}

	override function render(frameBuffer:Framebuffer):Void
	{
		super.render(frameBuffer);		
		
		var g = backbuffer.g2;
		g.font = this.font;

		// clear our backbuffer using graphics2
		g.begin(true, Color.Black);
		g.drawImage(images["background"], 0, 0);
		g.drawImage(images["scenery"], 25, 75);
		g.drawImage(images["player"], 150, 150);
		g.drawImage(images["monster"], 550, 150);

		g.fontSize = 72;
		g.drawString("Location: Merry Meadows", 100, 0);

		g.fontSize = 36;
		g.drawString("Level: 1 (0/250xp)", 25, 325);
		g.drawString("Coins: 0 gold, 0 silver", 25, 350);

		g.drawImage(images["item button"], 575, 350);
		g.drawImage(images["shop button"], 650, 350);
		g.drawImage(images["quit button"], 725, 350);

		g.drawString(this.game.lastMessage, 10, 415);

		g.end();

		// draw our backbuffer onto the active framebuffer
		frameBuffer.g2.begin();
		Scaler.scale(backbuffer, frameBuffer, System.screenRotation);
		frameBuffer.g2.end();
	}
}