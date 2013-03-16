package dust.commands;

interface Command<T>
{
    function execute(data:T):Void;
}
