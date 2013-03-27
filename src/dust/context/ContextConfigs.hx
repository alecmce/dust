package dust.context;

import dust.Injector;
using Lambda;

class ContextConfigs
{
    var injector:Injector;
    var parent:ContextConfigs;

    var pending:Array<Class<Config>>;
    var configured:Array<Class<Config>>;
    var instances:Array<Config>;

    public function new(injector:Injector, parent:ContextConfigs = null)
    {
        this.injector = injector;
        this.parent = parent;

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
                return configured.has(config) ||
                       (parent != null && parent.configured.has(config));
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
        var count = instances.length;
        for (i in 0...count)
        {
            var instance = instances[count - i - 1];
            if (Std.is(instance, UnconfigConfig))
                cast (instance, UnconfigConfig).unconfigure();
        }

    }
}
