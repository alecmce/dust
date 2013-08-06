package dust.commands;

import dust.signals.PromiseVoid;
import dust.signals.Promise;
import dust.signals.PromiseMap;
import dust.Injector;

class PromiseCommandMap
{
    var injector:Injector;
    var promiseMap:PromiseMap;

    @inject public function new(injector:Injector, promiseMap:PromiseMap)
    {
        this.injector = injector;
        this.promiseMap = promiseMap;
    }

    public function map<T>(promise:Class<Promise<T>>, command:Class<Command<T>>)
    {
        var delegate = new CommandDelegate<T>(injector, command);
        promiseMap.map(promise, delegate.invoke);
    }

    public function mapVoid(promise:Class<PromiseVoid>, command:Class<CommandVoid>)
    {
        var delegate = new CommandVoidDelegate(injector, command);
        promiseMap.mapVoid(promise, delegate.invoke);
    }

    public function getInstance<T>(command:Class<Command<T>>):Command<T>
    {
        return if (injector.hasMapping(command))
            injector.getInstance(command);
        else
            injector.instantiate(command);
    }
}

