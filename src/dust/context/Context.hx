package dust.context;

import dust.signals.SignalVoid;
import dust.signals.Signal;
import dust.Injector;

import flash.display.Stage;
import flash.events.Event;
import flash.display.DisplayObjectContainer;

class Context
{
    public var started(default, null):SignalVoid;
    public var stopped(default, null):SignalVoid;

    public var injector(default, null):Injector;

    var configs:ContextConfigs;
    var root:DisplayObjectContainer;

    public function new(parent:Context = null)
    {
        injector = new Injector(parent != null ? parent.injector : null);
        configs = new ContextConfigs(injector, parent != null ? parent.configs : null);
        started = new SignalVoid();
        stopped = new SignalVoid();
        mapDefaultInjections();
    }

        function mapDefaultInjections()
        {
            injector.mapValue(Context, this);
            injector.mapValue(Stage, flash.Lib.current.stage);
            injector.mapValue(Injector, injector);
        }

    public function configure(config:Class<Config>):Context
    {
        configs.add(config);
        return this;
    }

    public function start(root:DisplayObjectContainer):Context
    {
        this.root = root;
        injector.mapValue(DisplayObjectContainer, root);
        configs.configure();
        flash.Lib.current.addChildAt(root, 0);
        started.dispatch();
        return this;
    }

    public function stop()
    {
        configs.unconfigure();
        root.parent.removeChild(root);
        stopped.dispatch();
    }
}
