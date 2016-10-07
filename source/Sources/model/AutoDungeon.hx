package model;

import model.Entity;
import model.states.GameState;
import model.states.PassiveWaitState;

// Model class representing one instance of our game universe.
// Separated from the view which is a best practice.
class AutoDungeon
{    
    public var state:GameState;
    public var lastMessage(get, null):String;

    private var player:Entity = new Entity("Player", 20, 5, 3);
    private var accumulator:Float;

    public function new()
    {
         this.state = PassiveWaitState.town(player, "Swatting Torn");
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
        return this.state.message;
    }

    private function advanceTimeBy(seconds:Int):Void
    {
        this.state.update(seconds);

        if (this.state.isComplete())
        {
            this.state = this.state.getNextState();
        }
    }
}