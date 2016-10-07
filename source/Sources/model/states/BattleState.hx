package model.states;

import model.Entity;

class BattleState extends PassiveWaitState // TODO: GameState
{
    public static var monsterNames:Array<String>;

    // Parameterized construction of common events (eg. fighting, towns)

    public static function fighting(player:Entity, monsterName:String = ""):BattleState
    {
        if (monsterName == "")
        {
            var n = Math.floor(Math.random() * monsterNames.length);
            monsterName = monsterNames[n];
        }
        return new BattleState(player, 'Fighting a ${monsterName}', monsterName, StateType.Fighting, 10);
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
            return PassiveWaitState.wilderness(this.player);
        }
        else
        {
            return BattleState.fighting(this.player);
        }
    }
}