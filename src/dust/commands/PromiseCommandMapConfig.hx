package dust.commands;

import dust.signals.PromiseMapConfig;
import dust.commands.PromiseCommandMap;
import dust.context.DependentConfig;
import dust.Injector;
import dust.context.Config;

class PromiseCommandMapConfig implements DependentConfig
{
    @inject public var injector:Injector;

    public function dependencies():Array<Class<Config>>
        return [PromiseMapConfig];

    public function configure()
        injector.mapSingleton(PromiseCommandMap);
}