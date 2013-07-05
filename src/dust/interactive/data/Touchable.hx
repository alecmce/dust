package dust.interactive.data;

import dust.entities.Entity;

class Touchable
{
    public var execute:Entity->Void;

    public function new(execute:Entity->Void)
        this.execute = execute;
}
