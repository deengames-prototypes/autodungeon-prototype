package model.states;

class PassiveWaitState extends GameState
{
    public var durationInSeconds(default, null):Int = 0;
    
    public var type(default, null):StateType;
    private var elapsedTime:Float = 0;

    public function new(message:String, imageKey:String, type:StateType, durationInSeconds:Int)
    {
        super(message, imageKey);
        this.type = type;
        this.durationInSeconds = durationInSeconds;
    }

    override public function get_message():String
    {
        var dots = Math.floor(this.elapsedTime);        
        var toReturn = '${this.baseMessage} ';
        var maxDots = Std.int(Math.min(dots, this.durationInSeconds));
        for (i in 0 ... maxDots)
        {
            toReturn = '${toReturn}.';
        } 
        return toReturn;
    }

    public static function town(townName:String = ""):PassiveWaitState
    {
        // TODO: different image per town?
        return new PassiveWaitState('Exploring the town of ${townName}', "town", StateType.Town, 10);
    }

    public static function wilderness():PassiveWaitState
    {
        return new PassiveWaitState("Exploring the wilderness", "forest", StateType.Wilderness, 3);
    }

    override public function isComplete():Bool
    {
        return this.elapsedTime >= this.durationInSeconds;
    }

    override public function update(elapsedTime:Float):Void
    {
        this.elapsedTime += elapsedTime;
    }

    override public function getNextState():GameState
    {
        if (this.type == StateType.Town)
        {
            return PassiveWaitState.wilderness();
        }
        else
        {
            return BattleState.fighting();
        }
    }
}