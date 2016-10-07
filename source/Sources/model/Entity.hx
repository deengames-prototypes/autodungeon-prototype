package model;

// Monster or player
class Entity
{
    public var name(default, null):String;
    public var currentHealth(default, null):Int;
    public var maxHealth(default, null):Int;
    public var strength(default, null):Int;
    public var defense(default, null):Int;
    
    public function new(name:String, health:Int, strength:Int, defense:Int)
    {
        this.name = name;
        this.currentHealth = this.maxHealth = health;
        this.strength = strength;
        this.defense = defense;
    }
}