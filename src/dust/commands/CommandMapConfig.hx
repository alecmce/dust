package dust.commands;

import dust.signals.SignalMapConfig;
import dust.context.DependentConfig;
import dust.commands.CommandMap;
import minject.Injector;
import dust.context.Config;

class CommandMapConfig implements DependentConfig
{
    @inject public var injector:Injector;

    public function dependencies():Array<Class<Config>>
        return [SignalMapConfig]

    public function configure()
        injector.mapSingleton(CommandMap)
}