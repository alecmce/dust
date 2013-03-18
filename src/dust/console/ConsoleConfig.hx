package dust.console;

import dust.app.CommandMapConfig;
import dust.app.SignalMapConfig;
import dust.commands.CommandMap;
import dust.context.Context;
import dust.console.control.MapConsoleMethodsCommand;
import dust.console.control.MapConsoleMethodsSignal;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleOutput;
import dust.console.ui.ConsoleInput;
import dust.console.control.DefaultConsoleListeners;
import dust.console.control.HideConfigSignal;
import dust.console.control.ShowConfigSignal;
import dust.console.impl.Console;
import dust.console.impl.ConsoleMap;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.context.UnconfigConfig;
import dust.signals.SignalMap;

import minject.Injector;
import nme.display.Stage;
import nme.events.KeyboardEvent;
import nme.text.TextFormat;
import nme.ui.Keyboard;

class ConsoleConfig implements DependentConfig, implements UnconfigConfig
{
    @inject public var context:Context;
    @inject public var injector:Injector;
    @inject public var stage:Stage;
    @inject public var signalMap:SignalMap;
    @inject public var commandMap:CommandMap;

    var input:ConsoleInput;
    var output:ConsoleOutput;
    var map:ConsoleMap;
    var console:Console;
    var listeners:DefaultConsoleListeners;

    public function dependencies():Array<Class<Config>>
        return [SignalMapConfig, CommandMapConfig]

    public function configure()
    {
        injectConsole();
        mapSignals();
        mapCommands();
        enableListener();

        context.started.bindOnce(onStarted);
    }

        function injectConsole()
        {
            injector.mapSingleton(ConsoleFormat);
            injector.mapSingleton(ConsoleMap);
            injector.mapSingleton(ConsoleInput);
            injector.mapSingleton(ConsoleOutput);
            injector.mapSingleton(Console);
        }

        function mapSignals()
        {
            console = injector.getInstance(Console);
            signalMap.mapVoid(ShowConfigSignal, console.enable);
            signalMap.mapVoid(HideConfigSignal, console.disable);
        }

        function mapCommands()
        {
            commandMap.mapVoid(MapConsoleMethodsSignal, MapConsoleMethodsCommand);
        }

        function enableListener()
        {
            listeners = new DefaultConsoleListeners(console);
            listeners.enable();
        }

        function onStarted()
        {
            injector.getInstance(MapConsoleMethodsSignal).dispatch();
        }

    public function unconfigure()
    {
        console.disable();
        listeners.disable();

        signalMap.unmapVoid(ShowConfigSignal, console.enable);
        signalMap.unmapVoid(HideConfigSignal, console.disable);
        injector.unmap(ConsoleMap);
        injector.unmap(Console);
    }

}