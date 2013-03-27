package dust.commands;

import dust.Injector;

class CommandVoidDelegate
{
    var injector:Injector;
    var command:Class<CommandVoid>;
    var instance:CommandVoid;

    public function new(injector:Injector, command:Class<CommandVoid>)
    {
        this.injector = injector;
        this.command = command;
        injector.mapSingleton(command);
    }

    public function invoke()
    {
        getInstance().execute();
    }

    inline function getInstance():CommandVoid
    {
        if (instance == null)
            instance = injector.getInstance(command);
        return instance;
    }
}