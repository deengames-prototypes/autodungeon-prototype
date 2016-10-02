package model;

// Model class representing one instance of our game universe.
// Separated from the view which is a best practice.
class AutoDungeon
{    
    public var playerState:PlayerState = PlayerState.Town("Swatting Torn");
    public var lastMessage(get, null):String;
    private var accumulator:Float;

    // TODO: delete
    private static var x:Int = 0;

    public function new()
    {
    }

    public function update(elapsedSeconds:Float):Void
    {
        this.accumulator += elapsedSeconds;
        if (this.accumulator >= 1)
        {
            var seconds = Math.floor(this.accumulator);
            this.advanceTimeBy(seconds);
            this.accumulator -= seconds;
        }
    }

    public function get_lastMessage():String
    {
        return this.playerState.message;
    }

    private function advanceTimeBy(seconds:Int):Void
    {
        this.playerState.update(seconds);

        if (this.playerState.isComplete())
        {
            // TODO: this is becoming a FSM. Can we do better here?
            switch this.playerState.type
            {
                case StateType.Town: this.playerState = PlayerState.Wilderness();
                case StateType.Wilderness: this.playerState = PlayerState.Fighting();
                case StateType.Fighting: this.playerState = PlayerState.Wilderness();
            }
        }
    }
}