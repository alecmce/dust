package dust.context;

import dust.signals.PromiseVoid;

using Lambda;

class Configs
{
    public var pending:Array<Class<Config>>;
    public var configured:Array<Config>;

    public function new()
    {
        this.pending = new Array<Class<Config>>();
        this.configured = new Array<Config>();
    }
}