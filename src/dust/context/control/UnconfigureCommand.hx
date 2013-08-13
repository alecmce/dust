package dust.context.control;

class UnconfigureCommand
{
    var configs:Map<Class<Config>, Config>;
    var pending:Array<Config>;

    public function new(configs:Map<Class<Config>, Config>, pending:Array<Config>)
    {
        this.configs = configs;
        this.pending = pending;
    }

    public function unconfigure()
    {
        for (key in configs.keys())
        {
            unconfigureConfig(key);
        }
    }

    function unconfigureConfig(config:Class<Config>)
    {
        var config = configs.get(key);
        if (isUnconfig(config))
            unconfigureInstance(cast config);

        configs.remove(key);
    }

    function isUnconfig(config:Config):Bool
    {
        return Std.is(config, UnconfigConfig);
    }

    function unconfigureInstance(config:UnconfigConfig)
    {
        pending.remove(config);
        config.unconfigure();
    }
}