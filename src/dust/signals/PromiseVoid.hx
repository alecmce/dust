package dust.signals;

using Lambda;

class PromiseVoid
{
	public var count(default, null):Int;

	var listeners:List<Void->Void>;
    var isDispatched:Bool;

	public function new()
	{
		count = 0;
		listeners = new List<Void->Void>();
	}

	public function bind(fn:Void->Void)
	{
        if (isDispatched)
            fn();
        else if (!listeners.has(fn))
            bindToListeners(fn);
	}

	public function unbind(fn:Void->Void):Bool
	{
        var isOldBind = listeners.has(fn);
        if (isOldBind)
        {
            listeners.remove(fn);
            --count;
        }

        return isOldBind;
	}

	public function unbindAll():Void
	{
		count = 0;
		untyped listeners.length = 0;
	}
	
	inline public function dispatch():Void
	{
        isDispatched = true;
        if (hasListeners())
            dispatchToListeners();
    }

    inline public function hasListeners():Bool
    {
        return count > 0;
    }

    inline function dispatchToListeners()
    {
		for (fn in listeners)
			fn();
		
		count = 0;
		untyped listeners.length = 0;
	}

	inline function bindToListeners(fn:Void->Void)
	{
        if (!listeners.has(fn))
		{
			listeners.push(fn);
			++count;
		}
	}
}