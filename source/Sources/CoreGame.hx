package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;
import kha.Font;
import kha.Image;
import kha.Scaler;
import kha.Assets;

import model.AutoDungeon;

class CoreGame {

  	public static inline var screenWidth = 800;
  	public static inline var screenHeight = 450;

	private var backbuffer:Image;
	private var images:Map<String, Image> = new Map<String, Image>();

	private var font:Font;

	private var initialized:Bool = false;
	private var game:AutoDungeon = new AutoDungeon(); // TODO: persist data
	private var lastUpdateTime:Float = 0;

	public function new()
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);

		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);

		Assets.loadEverything(function()
		{			
			initialized = true;
			images["background"] = Assets.images.background;
			images["player"] = Assets.images.player;
			images["scenery"] = Assets.images.scenery;
			images["monster"] = Assets.images.monster;
			images["item button"] = Assets.images.button_items;
			images["shop button"] = Assets.images.button_shop;
			images["quit button"] = Assets.images.button_quit;
			font = Assets.fonts.biryani;
		});	}

	function update(): Void
	{
		var now = Scheduler.realTime();
		var elapsedSeconds = now - lastUpdateTime;
		this.game.update(elapsedSeconds);
		this.lastUpdateTime = now;
	}

	function render(framebuffer: Framebuffer): Void
	{
		if (!initialized)
		{
			return;
		}		
		
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
		framebuffer.g2.begin();
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
	}
}