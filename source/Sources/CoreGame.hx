package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;
import kha.Image;
import kha.Scaler;
import kha.Assets;

class CoreGame {

  	public static inline var screenWidth = 800;
  	public static inline var screenHeight = 450;

	private var backbuffer:Image;
	private var background:Image;
	private var initialized:Bool = false;

	public function new()
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);

		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		Assets.loadEverything(function()
		{			
			initialized = true;
			background = Assets.images.background;
		});
	}

	function update(): Void
	{
		
	}

	function render(framebuffer: Framebuffer): Void
	{
		if (!initialized)
		{
			return;
		}		
		
		var g = backbuffer.g2;

		// clear our backbuffer using graphics2
		g.begin(true, Color.Black);
		g.drawImage(background, 0, 0);
		g.end();

		// draw our backbuffer onto the active framebuffer
		framebuffer.g2.begin();
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
	}
}