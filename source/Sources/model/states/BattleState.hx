package model.states;

class BattleState extends PassiveWaitState // TODO: GameState
{
    public static var monsterNames:Array<String>;

    // Parameterized construction of common events (eg. fighting, towns)

    public static function fighting(monsterName:String = ""):BattleState
    {
        if (monsterName == "")
        {
            var n = Math.floor(Math.random() * monsterNames.length);
            monsterName = monsterNames[n];
        }
        return new BattleState('Fighting a ${monsterName}', monsterName, StateType.Fighting, 10);
    }
}