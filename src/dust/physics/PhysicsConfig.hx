package dust.physics;

import dust.physics.systems.WritePhysicsToPositionSystem;
import dust.geom.data.Position;
import dust.physics.data.Physics;
import dust.physics.data.State;
import dust.physics.systems.PhysicsSystem;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;
import dust.context.DependentConfig;
import dust.context.Config;

class PhysicsConfig implements DependentConfig
{
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [SystemsConfig]

    public function configure()
    {
        systems
            .map(PhysicsSystem)
            .toCollection([State, Physics])
            .withName("Physics");

        systems
            .map(WritePhysicsToPositionSystem)
            .toCollection([State, Position])
            .withName("Write Physics To Position");
    }
}
