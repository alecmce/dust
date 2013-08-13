package dust.context.control;

import dust.signals.PromiseVoid;

class ConfigureCommand
{
    var injector:Injector;
    var configs:Map<Class<Config>, Config>;
    var pending:Array<Config>;
    var ready:PromiseVoid;

    var isWaiting:Bool;

    public function new(injector:Injector, configs:Map<Class<Config>, Config>, pending:Array<Config>, ready:PromiseVoid)
    {
        this.injector = injector;
        this.configs = configs;
        this.pending = pending;
        this.ready = ready;
    }

    public function execute()
    {
        isWaiting = false;
        while (!isWaiting && pending.length > 0)
            configureNextPending();

        if (!isWaiting && pending.length == 0)
            ready.dispatch();
    }

        function configureNextPending()
        {
            var config = pending.pop();
            if (isAsync(config))
                handleAsync(cast config);

            configureInstance(config);
        }

            function isAsync(config:Config):Bool
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