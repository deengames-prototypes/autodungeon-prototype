import kha.Assets;
import kha.Font;
import kha.Framebuffer;
import kha.Image;
import kha.Scheduler;
import kha.System;

/** Don't use this class directly. It has boilerplate code. Subclass it. */
class BaseGame
{
    private var screenWidth = 0;
  	private var screenHeight = 0;
      
	private var font:Font;
    private var backbuffer:Image;

	private var initialized:Bool = false;

    private var lastUpdateTime:Float = 0;

    public function new(screenWidth:Int, screenHeight:Int)
    {
        this.screenWidth = screenWidth;
        this.screenHeight = screenHeight;

        System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);

		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
    }

    private function loadAssets(callback:Void->Void):Void
    {
        Assets.loadEverything(function()
		{
            initialized = true;
            callback();
        });
    }

    private function update():Void
    {
        // virtual, override me
    }

    private function render(frameBuffer:Framebuffer):Void
    {
        // virtual, override me
    }
}