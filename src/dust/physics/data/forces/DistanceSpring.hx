package dust.physics.data.forces;

import dust.geom.data.Position;

class DistanceSpring implements Force
{
    public var other:Physics;
    public var restDistance:Float;          // the equilibrium distance for this spring
    public var tightness:Float;             // larger => will stretch less
    public var dampingCoefficient:Float;    // larger => come to rest more quickly

    public function new(other:Physics, ?restDistance:Float = 0, ?tightnessConstant:Float = 1, ?dampingCoefficient:Float = 1)
    {
        this.other = other;
        this.restDistance = restDistance;
        this.tightness = tightnessConstant;
        this.dampingCoefficient = dampingCoefficient;
    }

    public function apply(state:State, force:Derivative):Void
    {
        var forceDX = other.workingState.positionX - state.positionX;
        var forceDY = other.workingState.positionY - state.positionY;
        var currentDistance = Math.sqrt(forceDX * forceDX + forceDY * forceDY);

        var scalar = -tightness * (currentDistance - restDistance) / currentDistance;
        forceDX *= scalar;
        forceDY *= scalar;

        var dampingX = (other.workingState.velocityX - state.velocityX) * dampingCoefficient;
        var dampingY = (other.workingState.velocityY - state.velocityY) * dampingCoefficient;
        forceDX -= dampingX;
        forceDY -= dampingY;

        force.forceX -= forceDX;
        force.forceY -= forceDY;
    }
}
