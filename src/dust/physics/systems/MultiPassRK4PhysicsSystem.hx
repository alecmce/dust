package dust.physics.systems;

import dust.physics.data.Physics;
import dust.physics.data.Physics;
import dust.systems.System;
import dust.physics.data.State;
import dust.physics.data.Physics;
import dust.physics.data.Derivative;
import dust.collections.api.Collection;

class MultiPassRK4PhysicsSystem implements System
{
    @inject public var collection:Collection;

    inline static var ONE_SIXTH:Float = 1.0 / 6.0;

    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        var halfDeltaTime = deltaTime * 0.5;

        for (entity in collection)
            readCurrentStateToWorkingState(entity.get(Physics), entity.get(State));

        for (entity in collection)
            deriveForcesAtState(entity.get(Physics), entity.get(State), entity.get(Physics).a);

        for (entity in collection)
            applyDerivativeToState(entity.get(State), entity.get(Physics).a, halfDeltaTime, entity.get(Physics).state);

        for (entity in collection)
            deriveForcesAtState(entity.get(Physics), entity.get(State), entity.get(Physics).b);

        for (entity in collection)
            applyDerivativeToState(entity.get(State), entity.get(Physics).b, halfDeltaTime, entity.get(Physics).state);

        for (entity in collection)
            deriveForcesAtState(entity.get(Physics), entity.get(State), entity.get(Physics).c);

        for (entity in collection)
            applyDerivativeToState(entity.get(State), entity.get(Physics).c, deltaTime, entity.get(Physics).state);

        for (entity in collection)
            deriveForcesAtState(entity.get(Physics), entity.get(State), entity.get(Physics).d);

        var sixthDeltaTime = deltaTime * ONE_SIXTH;
        for (entity in collection)
            setStateToInterpolationOfApproximations(entity.get(Physics), entity.get(State), sixthDeltaTime);
    }

        inline function readCurrentStateToWorkingState(physics:Physics, state:State)
        {
            physics.state.read(state);
        }

        inline function deriveForcesAtState(physics:Physics, state:State, derivative:Derivative)
        {
            derivative.forceX = 0.0;
            derivative.forceY = 0.0;
            derivative.torque = 0.0;

            derivative.velocityX = state.velocityX;
            derivative.velocityY = state.velocityY;
            derivative.spin = state.spin;

            physics.apply(state, derivative);
        }

        inline function applyDerivativeToState(source:State, derivative:Derivative, deltaTime:Float, output:State)
        {
            output.read(source);
            output.positionX += derivative.velocityX * deltaTime;
            output.positionY += derivative.velocityY * deltaTime;
            output.rotation += derivative.spin * deltaTime;

            output.momentumX += derivative.forceX * deltaTime;
            output.momentumY += derivative.forceY * deltaTime;
            output.angularMomentum += derivative.torque * deltaTime;

            output.updateVelocityFromMomentum();
        }

        inline function setStateToInterpolationOfApproximations(physics:Physics, state:State, sixthDeltaTime:Float)
        {
            var a = physics.a;
            var b = physics.b;
            var c = physics.c;
            var d = physics.d;

            state.positionX += sixthDeltaTime * (a.velocityX + 2.0 * (b.velocityX + c.velocityX) + d.velocityX);
            state.positionY += sixthDeltaTime * (a.velocityY + 2.0 * (b.velocityY + c.velocityY) + d.velocityY);
            state.rotation += sixthDeltaTime * (a.spin + 2.0 * (b.spin + c.spin) + d.spin);

            state.momentumX += sixthDeltaTime * (a.forceX + 2.0 * (b.forceX + c.forceX) + d.forceX);
            state.momentumY += sixthDeltaTime * (a.forceY + 2.0 * (b.forceY + c.forceY) + d.forceY);
            state.angularMomentum += sixthDeltaTime * (a.torque + 2.0 * (b.torque + c.torque) + d.torque);
            state.updateVelocityFromMomentum();

            physics.state.read(state);
        }
}