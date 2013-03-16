package dust.keys;

import dust.systems.impl.Systems;
import dust.keys.impl.Keys;
import dust.keys.impl.KeyControl;
import dust.lists.SimpleList;
import dust.keys.impl.KeyControls;
import dust.keys.impl.KeyControllerSystem;
import dust.systems.impl.Systems;
import minject.Injector;
import dust.systems.SystemsConfig;
import dust.context.DependentConfig;
import dust.context.Config;

class KeysConfig implements DependentConfig
{
    @inject
    public var injector:Injector;

    @inject
    public var systems:Systems;

    public function dependencies():Array<Class<Config>>
    {
        return [SystemsConfig];
    }

    public function configure()
    {
        var list = new SimpleList<KeyControl>();
        var controls = new KeyControls(list);

        injector.mapSingleton(Keys);
        injector.mapValue(KeyControls, controls);

        systems
            .map(KeyControllerSystem)
            .withName("KeyController");
    }
}
