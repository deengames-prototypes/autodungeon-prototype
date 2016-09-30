package model;

import kha.Scheduler;

// Model class representing one instance of our game universe.
// Separated from the view which is a best practice.
class AutoDungeon
{
    public var lastMessage(default, null):String;
    private var lastMessageTime:Float; // from Scheduler.realTime()

    private static var x:Int = 0;

    public function new()
    {
        lastMessageTime = 0;
    }

    public function update():Void
    {
        var elapsedSeconds:Int = Math.floor(Scheduler.realTime() - lastMessageTime);
        if (elapsedSeconds >= 1)
        {
            lastMessageTime = Scheduler.realTime();
            this.advanceTimeBy(elapsedSeconds);
            lastMessage = 'Update ${x}!';
        }
    }

    private function advanceTimeBy(seconds:Int):Void
    {
        x += seconds;
    }
}