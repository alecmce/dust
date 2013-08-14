package dust.context.control;

import dust.commands.CommandVoid;

class ConfigureCommand implements CommandVoid
{
    @inject public var injector:Injector;
    @inject public var configs:Configs;
    @inject public var started:ContextStartedPromise;

    var index:Int;
    var isWaiting:Bool;

    public function execute()
    {
        isWaiting = false;
        index = 0;
        configure();
    }

        function configure()
        {
            while (!isWaiting && index < configs.pending.length)
                configureNextPending();

            if (!isWaiting && index == configs.pending.length)
                started.dispatch();
        }

            function configureNextPending()
            {
                var config = configs.pending[index++];
                var instance = configureInstance(config);
                if (isAsync(instance))
                    waitUntilAsyncIsReady(cast instance);
            }

                function configureInstance(config:Class<Config>):Config
                {
                    var instance = injector.instantiate(config);
                    configs.configured.push(instance);
                    instance.configure();
                    return instance;
                }

                function isAsync(config:Config):Bool
                {
                    return Std.is(config, AsyncConfig);
                }

                function waitUntilAsyncIsReady(config:AsyncConfig)
                {
                    isWaiting = true;
                    config.ready.bind(configure);
                }
}