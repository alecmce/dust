package dust.physics.data.forces;

import dust.physics.data.Derivative;

class DirectionalForce implements Force
{
    public var dx:Float;
    public var dy:Float;

    public function new(dx:Float, dy:Float)
    {
        this.dx = dx;
        this.dy = dy;
    }

    public function apply(state:State, force:Derivative)
    {
        force.forceX += dx;
        force.forceY += dy;
    }
}