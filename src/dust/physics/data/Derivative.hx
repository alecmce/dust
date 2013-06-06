package dust.physics.data;

class Derivative
{
    public var forceX:Float;            // x-component of the derivative of momentum
    public var forceY:Float;            // y-component of the derivative of momentum
    public var torque:Float;            // derivative of angular momentum

    public var velocityX:Float;         // x-component of derivative of position
    public var velocityY:Float;         // y-component of derivative of position
    public var spin:Float;              // derivative of rotation

    public function new() {}
}