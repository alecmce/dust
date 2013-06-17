package dust.physics.systems;

import dust.collections.api.Collection;
import dust.physics.data.Derivative;
import dust.physics.data.Physics;
import dust.physics.data.State;
import dust.systems.System;

class SinglePassRK4PhysicsSystem implements System
{
    @inject public var collection:Collection;

    inline static var ONE_SIXTH:Float = 1.0 / 6.0;

    var workingState:State;

    public function new()
    {
        workingState = new State();
    }

    public function start()
    {
        for (entity in collection)
            entity.get(Physics).state.read(entity.get(State));
    }

    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
        {
            var state:State = entity.get(State);
            var physics:Physics = entity.get(Physics);
            applyRK4IntegrationToStateUnderForces(physics, state, deltaTime);
        }
    }

    inline function applyRK4IntegrationToStateUnderForces(physics:Physics, state:State, deltaTime:Float)
    {
        var halfDeltaTime = deltaTime * 0.5;

        physics.state.read(state);
        deriveForcesAtState(physics, state, physics.a);
        applyDerivativeToState(state, physics.a, halfDeltaTime, workingState);
        deriveForcesAtState(physics, workingState, physics.b);
        applyDerivativeToState(state, physics.b, halfDeltaTime, workingState);
        deriveForcesAtState(physics, workingState, physics.c);
        applyDerivativeToState(state, physics.c, deltaTime, workingState);
        deriveForcesAtState(physics, workingState, physics.d);

        setStateToInterpolationOfApproximations(physics, state, deltaTime);
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

    inline function setStateToInterpolationOfApproximations(physics:Physics, state:State, deltaTime:Float)
    {
        var a = physics.a;
        var b = physics.b;
        var c = physics.c;
        var d = physics.d;

        var sixthTime = deltaTime * ONE_SIXTH;

        state.positionX += sixthTime * (a.velocityX + 2.0 * (b.velocityX + c.velocityX) + d.velocityX);
        state.positionY += sixthTime * (a.velocityY + 2.0 * (b.velocityY + c.velocityY) + d.velocityY);
        state.rotation += sixthTime * (a.spin + 2.0 * (b.spin + c.spin) + d.spin);

        state.momentumX += sixthTime * (a.forceX + 2.0 * (b.forceX + c.forceX) + d.forceX);
        state.momentumY += sixthTime * (a.forceY + 2.0 * (b.forceY + c.forceY) + d.forceY);
        state.angularMomentum += sixthTime * (a.torque + 2.0 * (b.torque + c.torque) + d.torque);
        state.updateVelocityFromMomentum();
    }
}