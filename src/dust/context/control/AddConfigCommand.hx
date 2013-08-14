package dust.context.control;

import dust.commands.Command;

using Lambda;

class AddConfigCommand implements Command<Class<Config>>
{
    @inject public var configs:Configs;

    public function execute(config:Class<Config>)
    {
        if (!isConfigured(config))
            addConfig(config);
    }

        function isConfigured(config:Class<Config>):Bool
        {
            return configs.pending.has(config);
        }

        function addConfig(config:Class<Config>)
        {
            configureDependencies(config);
            configs.pending.push(config);
        }

            function configureDependencies(config:Class<Config>)
            {
                var instance = Type.createEmptyInstance(config);
                if (hasDependencies(instance))
                    addDependencies(cast instance);
            }

                function hasDependencies(config:Config):Bool
                {
                    return Std.is(config, DependentConfig);
                }

                function addDependencies(config:DependentConfig)
                {
                    for (dependency in config.dependencies())
                        execute(dependency);
                }
}
