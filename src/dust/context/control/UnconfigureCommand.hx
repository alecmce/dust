package dust.context.control;

import dust.commands.CommandVoid;

class UnconfigureCommand implements CommandVoid
{
    @inject public var configs:Configs;

    var index:Int;

    public function execute()
    {
        index = configs.configured.length;
        while (index-- > 0)
            unconfigure(configs.configured[index]);

        untyped configs.configured.length = 0;
    }

        function unconfigure(config:Config)
        {
            if (isUnconfig(config))
                unconfigureInstance(cast config);
        }

            function isUnconfig(config:Config):Bool
            {
                return Std.is(config, UnconfigConfig);
            }

            function unconfigureInstance(config:UnconfigConfig)
            {
                config.unconfigure();
            }
}