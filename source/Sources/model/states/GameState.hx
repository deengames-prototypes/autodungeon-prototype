package model.states;

import model.Entity;

// Abstract
class GameState
{
    public var message(get, null):String; // Public message for UI
    public var imageKey(default, null):String; // Image to show in UI. Key (images[x] in CoreGame)
    private var player(null, default):Entity;
    
    private var baseMessage:String;

    public function new(player:Entity, baseMessage:String, imageKey:String)
    {
        trace('Base: player = ${player}');
        this.player = player;
        this.baseMessage = baseMessage;
        this.imageKey = imageKey;
    }

    // override
    public function get_message():String { return this.baseMessage; }
    // override
    public function update(elapsedTime:Float):Void { }
    // override
    public function isComplete():Bool { return false; }
    // override
    public function getNextState():GameState { return this; }
}
