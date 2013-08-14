package dust.console;

import dust.app.AppConfig;
import dust.commands.CommandMapConfig;
import dust.signals.SignalMapConfig;
import dust.commands.CommandMap;
import dust.context.Context;
import dust.console.control.MapConsoleMethodsCommand;
import dust.console.control.MapConsoleMethodsSignal;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleOutput;
import dust.console.ui.ConsoleInput;
import dust.console.control.DefaultConsoleListeners;
import dust.console.control.HideConsoleSignal;
import dust.console.control.ShowConsoleSignal;
import dust.console.impl.Console;
import dust.console.impl.ConsoleMap;
import dust.context.DependentConfig;
import dust.context.Config;
import dust.context.UnconfigConfig;
import dust.signals.SignalMap;

import dust.Injector;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.text.TextFormat;
import flash.ui.Keyboard;

class ConsoleConfig
    implements DependentConfig
    implements UnconfigConfig
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
        return [AppConfig, SignalMapConfig, CommandMapConfig];

    public function configure()
    {
        injectConsole();
        mapSignals();
        mapCommands();
        enableListener();

        context.started.bind(onStarted);
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
            signalMap.mapVoid(ShowConsoleSignal, console.enable);
            signalMap.mapVoid(HideConsoleSignal, console.disable);
        }

        function mapCommands()
        {
            commandMap.mapVoid(MapConsoleMethodsSignal, MapConsoleMethodsCommand);
        }

        function enableListener()
        {
            listeners = new DefaultConsoleListeners(stage, console);
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

        signalMap.unmapVoid(ShowConsoleSignal, console.enable);
        signalMap.unmapVoid(HideConsoleSignal, console.disable);
        injector.unmap(ConsoleMap);
        injector.unmap(Console);
    }

}