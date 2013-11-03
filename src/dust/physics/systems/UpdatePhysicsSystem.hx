package dust.physics.systems;

import dust.physics.data.Forces;
import dust.physics.data.RK4Position;
import dust.geom.data.Delta;
import dust.geom.data.Position;
import dust.entities.Entity;
import dust.collections.api.Collection;
import dust.systems.System;

class UpdatePhysicsSystem implements System
{
    @inject public var collection:Collection;

    var rk4:RK4Property;

    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
            update(entity, deltaTime);
    }

        inline function update(entity:Entity, deltaTime:Float)
        {
            var physics:RK4Position = entity.get(RK4Position);
            var forces:Forces = entity.get(Forces);
            var position:Position = entity.get(Position);

            physics.update(forces, deltaTime);
            physics.writePosition(position);
        }
}

class RK4Property
{
    public var value:Float;
    public var delta:Float;

    var k0value:Float; var k0delta:Float;
    var k1value:Float; var k1delta:Float;
    var k2value:Float; var k2delta:Float;
    var k3value:Float; var k3delta:Float;
    var k4value:Float; var k4delta:Float;

    public function new()
    {
        value = 0;
        delta = 0;

        k0value = 0.0; k0delta = 0.0;
        k1value = 0.0; k1delta = 0.0;
        k2value = 0.0; k2delta = 0.0;
        k3value = 0.0; k3delta = 0.0;
        k4value = 0.0; k4delta = 0.0;
    }

    inline public function set(value:Float, delta:Float)
    {
        this.value = value;
        this.delta = delta;
    }

    public function update(deltaTime:Float, force:Forces)
    {
        var halfDeltaTime = deltaTime * 0.5;

        k1value = delta + k0delta * 0;
        k1delta = force(value + k0value * 0, k1value, 0);

        k2value = delta + k1delta * halfDeltaTime;
        k2delta = force(value + k1value * halfDeltaTime, k2value, halfDeltaTime);

        k3value = delta + k2delta * halfDeltaTime;
        k3delta = force(value + k2value * halfDeltaTime, k3value, halfDeltaTime);

        k4value = delta + k3delta * deltaTime;
        k4delta = force(value + k3value * deltaTime, k4value, deltaTime);

        deltaTime *= 0.16666666666666666;
        value += deltaTime * (k1value + 2 * (k2value + k3value) + k4value);
        delta += deltaTime * (k1delta + 2 * (k2delta + k3delta) + k4delta);
    }

        inline function applyForce()
}