package dust.camera;

import dust.collections.CollectionsConfig;
import dust.camera.config.CameraDecorator;
import dust.entities.EntitiesConfig;
import dust.entities.api.Entities;
import dust.camera.data.Camera;
import dust.context.Config;
import dust.context.DependentConfig;

import minject.Injector;

class CameraConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var entities:Entities;

    var screenCenterX:Int;
    var screenCenterY:Int;
    var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [CollectionsConfig]

    public function configure()
    {
        var camera = makeCamera();
        injector.mapValue(Camera, camera);
        injector.mapSingleton(CameraDecorator);

        var entity = entities.require();
        entity.add(camera);
    }

        function makeCamera():Camera
        {
            var stage = nme.Lib.current.stage;
            screenCenterX = Std.int(stage.stageWidth * 0.5);
            screenCenterY = Std.int(stage.stageHeight * 0.5);

            return new Camera(screenCenterX, screenCenterY);
        }
}