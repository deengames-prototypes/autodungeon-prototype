package model;

class PlayerState
{
    public static var monsterNames:Array<String>;
    
    public var message(get, null):String; // Public message for UI
    public var durationInSeconds(default, null):Int = 0;
    public var imageKey(default, null):String; // Image to show in UI. Key (images[x] in CoreGame)

    public var type(default, null):StateType;
    private var displayMessage:String;
    private var elapsedTime:Float = 0;

    public function new(message:String, durationInSeconds:Int, imageKey:String, type:StateType)
    {
        this.displayMessage = message;
        this.durationInSeconds = durationInSeconds;
        this.imageKey = imageKey;
        this.type = type;
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

    // Region: parameterized construction of common events (eg. fighting, towns)

    public static function Fighting(monsterName:String = ""):PlayerState
    {
        if (monsterName == "")
        {
            var n = Math.floor(Math.random() * monsterNames.length);
            monsterName = monsterNames[n];
        }
        return new PlayerState('Fighting a ${monsterName}', 10, monsterName, StateType.Fighting);
    }

    public static function Town(townName:String = ""):PlayerState
    {
        // TODO: different image per town?
        return new PlayerState('Exploring the town of ${townName}', 10, "town", StateType.Town);
    }

    public static function Wilderness():PlayerState
    {
        return new PlayerState("Exploring the wilderness", 5, "forest", StateType.Wilderness);
    }

    //  Endregion

    public function isComplete():Bool
    {
        return this.elapsedTime >= this.durationInSeconds;
    }
}