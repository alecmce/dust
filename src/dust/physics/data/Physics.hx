package dust.physics.data;

import dust.physics.data.Derivative;

class Physics
{
    public var a:Derivative;
    public var b:Derivative;
    public var c:Derivative;
    public var d:Derivative;
    public var state:State;

    var forces:Array<Force>;

    public function new()
    {
        a = new Derivative();
        b = new Derivative();
        c = new Derivative();
        d = new Derivative();

        state = new State();
        forces = new Array<Force>();
    }

    public function addForce(force:Force):Physics
    {
        forces.push(force);
        return this;
    }

    public function apply(state:State, derivative:Derivative)
    {
        for (force in forces)
            force.apply(state, derivative);
    }
}