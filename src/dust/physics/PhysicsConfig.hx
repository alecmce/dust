package dust.physics;

import dust.systems.System;
import dust.physics.systems.MultiPassRK4PhysicsSystem;
import dust.physics.systems.SinglePassRK4PhysicsSystem;
import dust.physics.systems.WritePhysicsToPositionSystem;
import dust.geom.data.Position;
import dust.physics.data.Physics;
import dust.physics.data.State;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;
import dust.context.DependentConfig;
import dust.context.Config;

class PhysicsConfig implements DependentConfig
{
    inline static var USE_MULTIPASS = true;

    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [SystemsConfig];

    public function configure()
    {
        systems
            .map(getPhysicsSystem())
            .toCollection([State, Physics])
            .withTimedUpdate(1 / 100.0)
            .withName("Physics");

        systems
            .map(WritePhysicsToPositionSystem)
            .toCollection([State, Position])
            .withName("Write Physics To Position");
    }

        function getPhysicsSystem():Class<System>
        {
            return if (USE_MULTIPASS)
                cast MultiPassRK4PhysicsSystem;
            else
                cast SinglePassRK4PhysicsSystem;
        }
}
