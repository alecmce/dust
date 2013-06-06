package dust.physics.data;

import dust.physics.data.Derivative;
class Damping implements Force
{
    public var linear:Float;
    public var angular:Float;

    public function apply(state:State, force:Derivative)
    {
        force.forceX -= linear * state.dx;
        force.forceY -= linear * state.dy;
        force.torque -= angular * state.dr;
    }
}
