package dust.keys.impl;

class KeyControl
{
    public var key(default, null):Int;
    var method:Float->Void;

    public function new(key:Int, method:Float->Void)
    {
        this.key = key;
        this.method = method;
    }

    inline public function call(deltaTime:Float)
    {
        method(deltaTime);
    }
}
