package dust.camera.eg;

import dust.camera.systems.KeysMoveCameraSystem;
import dust.camera.CameraConfig;
import dust.keys.KeysConfig;
import dust.context.Config;
import dust.systems.impl.Systems;
import dust.camera.data.Camera;
import dust.context.DependentConfig;

class MoveCameraExample implements DependentConfig
{
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [KeysConfig, CameraConfig];

    public function configure()
    {
        systems
            .map(KeysMoveCameraSystem, 0)
            .toCollection([Camera])
            .withName("KeysMoveCamera");
    }
}
