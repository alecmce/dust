package dust.commands;

import dust.Injector;

class CommandDelegate<T>
{
    var injector:Injector;
    var command:Class<Command<T>>;
    var instance:Command<T>;

    public function new(injector:Injector, command:Class<Command<T>>)
    {
        this.injector = injector;
        this.command = command;
        injector.mapSingleton(command);
    }

    public function invoke(data:T)
    {
        getInstance().execute(data);
    }

    inline function getInstance():Command<T>
    {
        if (instance == null)
            instance = injector.getInstance(command);
        return instance;
    }
}