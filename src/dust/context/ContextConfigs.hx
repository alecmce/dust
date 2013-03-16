package dust.context;

import minject.Injector;
using Lambda;

class ContextConfigs
{
    var injector:Injector;
    var pending:Array<Class<Config>>;
    var configured:Array<Class<Config>>;
    var instances:Array<Config>;

    public function new(injector:Injector)
    {
        this.injector = injector;
        pending = new Array<Class<Config>>();
        configured = new Array<Class<Config>>();
        instances = new Array<Config>();
    }

    public function add(config:Class<Config>)
    {
        pending.push(config);
    }

    public function configure()
    {
        for (config in pending)
            configureConfig(config);
    }

        function configureConfig(config:Class<Config>)
        {
            if (!isAlreadyConfigured(config))
                createInstanceAndConfigure(config);
        }

            function isAlreadyConfigured(config:Class<Config>):Bool
            {
                return configured.has(config);
            }

            function createInstanceAndConfigure(config:Class<Config>)
            {
                var instance:Config = Type.createEmptyInstance(config);
                if (isDependentConfig(instance))
                    configureDependencies(cast instance);

                configured.push(config);
                instances.push(instance);
                injector.injectInto(instance);
                instance.configure();
            }

                function isDependentConfig(instance:Config):Bool
                {
                    return Std.is(instance, DependentConfig);
                }

                function configureDependencies(instance:DependentConfig)
                {
                    for (config in instance.dependencies())
                        configureConfig(config);
                }

    public function unconfigure()
    {
        for (instance in instances)
        {
            if (Std.is(instance, UnconfigConfig))
                cast (instance, UnconfigConfig).unconfigure();
        }

    }
}
