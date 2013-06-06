package dust.physics.data.forces;

import dust.math.AnglesUtil;
import dust.math.AnglesUtil;
import dust.math.trig.Trig;
import dust.math.AnglesUtil;
import dust.geom.data.Position;

class AngularSpring implements Force
{
    public var trig:Trig;
    public var other:Physics;
    public var angularFlexion:Float;       // the amount of angle from aligned ignored by angular spring
    public var angularTightness:Float;      // the tightness of the angle
    public var dampingCoefficient:Float;    // larger => come to rest more quickly

    public function new(trig:Trig, other:Physics, ?angularFlexion:Float = 0, ?angularTightness:Float = 1, ?dampingCoefficient:Float = 1)
    {
        this.trig = trig;
        this.other = other;
        this.angularFlexion = angularFlexion;
        this.angularTightness = angularTightness;
        this.dampingCoefficient = dampingCoefficient;
    }

    public function apply(state:State, force:Derivative):Void
    {
        var targetAngle = state.rotation;
        var deltaX = other.workingState.positionX - state.positionX;
        var deltaY = other.workingState.positionY - state.positionY;

        var alpha = state.rotation;

        trig.setDirection(deltaX, deltaY);
        var beta = trig.getAngle();

        var angle = AnglesUtil.directedAngle(alpha, beta);
        if (angle > angularFlexion)
        {
            angle = AnglesUtil.constrainToHalfTurn(beta - alpha - angularFlexion);
            applyForce(-deltaY, deltaX, angle, force);
        }
        else if (angle < -angularFlexion)
        {
            angle = AnglesUtil.constrainToHalfTurn(beta - alpha + angularFlexion);
            applyForce(deltaY, -deltaX, angle, force);
        }
    }

        inline function applyForce(dx:Float, dy:Float, angle:Float, force:Derivative)
        {
            var scalar = angle * angularTightness / Math.sqrt(dx * dx + dy * dy);
            dx *= scalar;
            dy *= scalar;

            force.forceX += dx * scalar;
            force.forceY += dy * scalar;
            force.spin += angle;

//            var spin = AnglesUtil.directedAngle(state.rotation, angle);
//            if (spin != 0)
//            {
//                var angleScalar = -angularTightness * spin / angle;
//                spin *= angleScalar;
//
//                var dampingA = (other.angularMomentum - state.angularMomentum) * dampingCoefficient;
//                spin -= dampingA;
//
//                force.spin -= spin;
//            }
        }
}
