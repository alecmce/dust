package dust.systems.impl;

import dust.bitfield.Bitfield;
import dust.entities.Entity;
import dust.collections.api.Collection;

class CollectionDefinition
{
    public var collection:Collection;

    public var bitfield:Bitfield;
    public var sorter:Entity->Entity->Int;
    public var name:String;

    public function new(bitfield:Bitfield, sorter:Entity->Entity->Int, name:String = "")
    {
        this.bitfield = bitfield;
        this.sorter = sorter;
        this.name = name;
    }
}
