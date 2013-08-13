package dust.context.control;

class AddConfigCommand
{
    var configs:Map<Class<Config>, Config>;
    var pending:Array<Config>;

    public function new(configs:Map<Class<Config>, Config>, pending:Array<Config>)
    {
        this.configs = configs;
        this.pending = pending;
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
        if (hasDependencies(instance))
            addDependencies(cast instance)
    }

    function makeInstance(config:Class<Config>)
    {
        var instance = Type.createEmptyInstance(config);
        configs.set(config, instance);
        pending.push(config);
        return instance;
    }

    function hasDependencies(config:Config):Bool
    {
        return Std.is(config, DependentConfig);
    }

    function addDependencies(config:DependentConfig)
    {
        for (dependency in config.dependencies())
            add(dependency);
    }
}
