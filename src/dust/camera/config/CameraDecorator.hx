package dust.camera.config;

import dust.camera.data.Camera;
import dust.entities.api.Entity;

class CameraDecorator
{
    @inject public var camera:Camera;

    public function apply(entity:Entity)
        entity.add(camera);

    public function clear(entity:Entity)
        entity.remove(Camera);
}
