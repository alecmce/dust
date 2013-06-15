package dust.physics.data.forces;

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
        var dx = other.workingState.positionX - state.positionX;
        var dy = other.workingState.positionY - state.positionY;
        var distance = Math.sqrt(dx * dx + dy * dy);

        var invDistance = 1 / distance;
        var unitX = dx * invDistance;
        var unitY = dy * invDistance;

        var velocityX = other.workingState.velocityX - state.velocityX;
        var velocityY = other.workingState.velocityY - state.velocityY;

        var forceX = -tightness * (distance - restDistance) * unitX - dampingCoefficient * velocityX;
        var forceY = -tightness * (distance - restDistance) * unitY - dampingCoefficient * velocityY;

        force.forceX -= forceX;
        force.forceY -= forceY;
    }
}

