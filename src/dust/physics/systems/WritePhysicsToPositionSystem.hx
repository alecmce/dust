package dust.physics.systems;

import dust.math.AnglesUtil;
import dust.collections.api.Collection;
import dust.geom.data.Position;
import dust.physics.data.State;
import dust.entities.api.Entity;
import dust.systems.System;

class WritePhysicsToPositionSystem implements System
{
    @inject public var collection:Collection;

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
            var state:State = entity.get(State);
            var position:Position = entity.get(Position);

            position.x = state.positionX;
            position.y = state.positionY;
            position.rotation = AnglesUtil.constrainToHalfTurn(state.rotation);
        }
}
