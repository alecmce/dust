package dust.context;

import dust.signals.SignalVoid;
import nme.display.Stage;
import dust.signals.Signal;
import dust.Injector;

import nme.display.DisplayObjectContainer;

class Context
{
    public var started(default, null):SignalVoid;
    public var stopped(default, null):SignalVoid;

    public var injector:Injector;

    var configs:ContextConfigs;

    public function new(injector:Injector)
    {
        this.injector = injector;
        configs = new ContextConfigs(injector);
        started = new SignalVoid();
        stopped = new SignalVoid();
        mapDefaultInjections();
    }

        function mapDefaultInjections()
        {
            injector.mapValue(Context, this);
            injector.mapValue(Stage, nme.Lib.current.stage);
            if (!injector.hasMapping(Injector))
                injector.mapValue(Injector, injector);
        }

    public function configure(config:Class<Config>):Context
    {
        configs.add(config);
        return this;
    }

    public function start(root:DisplayObjectContainer):Context
    {
        injector.mapValue(DisplayObjectContainer, root);
        configs.configure();
        nme.Lib.current.addChild(root);
        started.dispatch();
        return this;
    }

    public function stop()
    {
        configs.unconfigure();
        var root = injector.getInstance(DisplayObjectContainer);
        nme.Lib.current.removeChild(root);
        stopped.dispatch();
    }
}
