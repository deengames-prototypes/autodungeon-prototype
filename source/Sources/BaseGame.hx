import kha.Assets;
import kha.Color;
import kha.Font;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.Image;
import kha.Scaler;
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

    ///// Start protected/internal functions \\\\\

    private function loadAssets(callback:Void->Void):Void
    {
        Assets.loadEverything(function()
		{
            initialized = true;
            callback();
        });
    }

    // Virtual functions to override
    private function onUpdate():Void { } 

    private function onRender(g:Graphics):Void { }

    private function update():Void
    {
        this.onUpdate();
    }

    private function drawImage(image:Image, x:Int, y:Int):Void
    {
        if (!initialized)
        {
            trace("Warning: can't call drawImage before calling loadAssets(...) to initialize the game.");
            return;
        }

        var g = backbuffer.g2;        
        g.drawImage(image, x, y);
    }

    

    private function drawText(text:String, x:Int, y:Int, fontSize:Int = 36):Void
    {
        if (!initialized)
        {
            trace("Warning: can't call drawImage before calling loadAssets(...) to initialize the game.");
            return;
        }

        var g = backbuffer.g2;    
        g.fontSize = fontSize;    
        g.drawString(text, x, y);
    }

    ///// End protected/internal functions \\\\\

    private function render(frameBuffer:Framebuffer):Void
    {
        if (initialized)
        {
            var g = backbuffer.g2;
            g.font = this.font;
            
            // clear our backbuffer using graphics2
            g.begin(true, Color.Black);

            this.onRender(g);
            
            g.end();
            // draw our backbuffer onto the active framebuffer
            frameBuffer.g2.begin();
            Scaler.scale(backbuffer, frameBuffer, System.screenRotation);
            frameBuffer.g2.end();
        }
    }
}