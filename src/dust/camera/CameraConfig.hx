package dust.camera;

import dust.app.data.AppTarget;
import dust.app.data.App;
import dust.app.AppConfig;
import dust.collections.CollectionsConfig;
import dust.camera.config.CameraDecorator;
import dust.entities.EntitiesConfig;
import dust.entities.api.Entities;
import dust.camera.data.Camera;
import dust.context.Config;
import dust.context.DependentConfig;

import dust.Injector;

class CameraConfig implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var app:App;
    @inject public var entities:Entities;

    var screenCenterX:Int;
    var screenCenterY:Int;
    var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [AppConfig, CollectionsConfig]

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
            screenCenterX = Std.int(app.stageWidth * 0.5);
            screenCenterY = Std.int(app.stageHeight * 0.5);

            return switch (app.target)
            {
                case AppTarget.IPAD_RETINA:
                    new Camera(screenCenterX, screenCenterY, 1);
                default:
                    new Camera(screenCenterX, screenCenterY, 0.5);
            }
        }
}
