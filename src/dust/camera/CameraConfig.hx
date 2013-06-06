package dust.camera;

import dust.camera.control.CameraFactory;
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

    public function dependencies():Array<Class<Config>>
        return [AppConfig, CollectionsConfig]

    public function configure()
    {
        injector.mapSingleton(CameraFactory);
        injector.mapSingleton(CameraDecorator);

        var factory = injector.getInstance(CameraFactory);
        injector.mapValue(Camera, factory.make());
    }
}
