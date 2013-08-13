package dust.context;

import dust.signals.PromiseVoid;

class Configs
{
    public var ready:PromiseVoid;

    var injector:Injector;
    var configs:Map<Class<Config>, Config>;
    var pending:Array<Config>;
    var isWaiting:Bool;

    public function new(injector:Injector)
    {
        ready = new PromiseVoid();

        this.injector = injector;
        configs = new Array<Class<Config>>();
        pending = new Array<Config>();
    }

    public function add(config:Class<Config>)
    {
        if (!isConfigured(config))
            addConfig(config);
    }

        function isConfigured(config:Class<Config>):Bool
        {
            return configs.exists(config);
        }

        function addConfig(config:Class<Config>)
        {
            var instance = makeInstance(config);
            if (isDependencyConfig(instance))
                addDependencies(cast instance)
        }

            function makeInstance(config:Class<Config>)
            {
                var instance = Type.createEmptyInstance(config);
                configs.set(config, instance);
                pending.push(config);
                return instance;
            }

            function isDependencyConfig(config:Config):Bool
            {
                return Std.is(config, DependentConfig);
            }

            function addDependencies(config:DependentConfig)
            {
                for (dependency in config.dependencies())
                    add(dependency);
            }

    public function configure()
    {
        isWaiting = false;
        while (!isWaiting && pending.length > 0)
        {
            var config = pending.pop();
            if (isAsyncConfig(config))
                handleAsync(cast config);

            configureInstance(config);
        }
    }

        function isAsyncConfig(config:Config):Bool
        {
            return Std.is(config, AsyncConfig);
        }

        function handleAsync(config:AsyncConfig)
        {
            isWaiting = true;
            config.ready.bind(configure);
        }

        function configureInstance(config:Config)
        {
            injector.injectInto(instance);
            config.configure();
        }
}
