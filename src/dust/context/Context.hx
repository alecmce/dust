package dust.context;

import dust.context.control.ContextStoppedPromise;
import dust.context.control.ContextStartedPromise;
import dust.context.control.UnconfigureCommand;
import dust.context.control.ConfigureCommand;
import dust.context.control.AddConfigCommand;
import dust.signals.PromiseVoid;
import dust.Injector;

import flash.display.Stage;
import flash.display.DisplayObjectContainer;

class Context
{
    public var started(default, null):PromiseVoid;
    public var stopped(default, null):PromiseVoid;

    public var injector(default, null):Injector;

    var root:DisplayObjectContainer;

    public function new(parent:Context = null)
    {
        injector = new Injector(parent != null ? parent.injector : null);
        mapDefaultInjections();
    }

        function mapDefaultInjections()
        {
            injector.mapValue(ContextStartedPromise, started = new ContextStartedPromise());
            injector.mapValue(ContextStoppedPromise, stopped = new ContextStoppedPromise());

            injector.mapValue(Context, this);
            injector.mapValue(Stage, flash.Lib.current.stage);
            injector.mapValue(Injector, injector);

            injector.mapSingleton(Configs);
            injector.mapSingleton(AddConfigCommand);
            injector.mapSingleton(ConfigureCommand);
            injector.mapSingleton(UnconfigureCommand);
        }

    public function configure(config:Class<Config>):Context
    {
        injector.getInstance(AddConfigCommand).execute(config);
        return this;
    }

    public function start(root:DisplayObjectContainer):Context
    {
        this.root = root;
        injector.mapValue(DisplayObjectContainer, root);
        injector.getInstance(ConfigureCommand).execute();
        flash.Lib.current.addChildAt(root, 0);
        return this;
    }

        function onReady()
        {
            started.dispatch();
        }

    public function stop()
    {
        root.parent.removeChild(root);
        injector.getInstance(UnconfigureCommand).execute();
        stopped.dispatch();
    }
}
