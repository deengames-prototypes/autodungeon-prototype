package model;

class PlayerState
{
    public static var FIGHTING_MONSTER:PlayerState = new PlayerState("Fighting a slime", 10);

    public var message(get, null):String;
    public var durationInSeconds(default, null):Int = 0;

    private var displayMessage:String;
    private var elapsedTime:Float = 0;

    public function new(message:String, durationInSeconds:Int)
    {
        this.displayMessage = message;
        this.durationInSeconds = durationInSeconds;
    }

    public function get_message():String
    {
        var dots = Math.floor(this.elapsedTime);        
        var toReturn = '${this.displayMessage} ';
        var maxDots = Std.int(Math.min(dots, this.durationInSeconds));
        for (i in 0 ... maxDots)
        {
            toReturn = '${toReturn}.';
        } 
        return toReturn;
    }

    public function update(elapsed:Float):Void
    {
        this.elapsedTime += elapsed;
    }
}