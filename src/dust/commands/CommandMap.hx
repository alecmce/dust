package dust.commands;

import dust.signals.SignalVoid;
import dust.signals.Signal;
import dust.signals.SignalMap;
import dust.Injector;

class CommandMap
{
    var injector:Injector;
    var signalMap:SignalMap;

    @inject
    public function new(injector:Injector, signalMap:SignalMap)
    {
        this.injector = injector;
        this.signalMap = signalMap;
    }

    public function map<T>(signal:Class<Signal<T>>, command:Class<Command<T>>)
    {
        var delegate = new CommandDelegate<T>(injector, command);
        signalMap.map(signal, delegate.invoke);
    }

    public function mapVoid(signal:Class<SignalVoid>, command:Class<CommandVoid>)
    {
        var delegate = new CommandVoidDelegate(injector, command);
        signalMap.mapVoid(signal, delegate.invoke);
    }

    public function getInstance<T>(command:Class<Command<T>>):Command<T>
    {
        return if (injector.hasMapping(command))
            injector.getInstance(command);
        else
            injector.instantiate(command);
    }
}

