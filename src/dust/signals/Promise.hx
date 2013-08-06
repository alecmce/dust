package dust.signals;

using Lambda;

class Promise<T>
{
	public var count(default, null):Int;

	var listeners:List<T->Void>;
    var isDispatched:Bool;
    var data:T;

	public function new()
	{
		count = 0;
		listeners = new List<T->Void>();
	}

	public function bind(fn:T->Void)
	{
        if (isDispatched)
            fn(data);
        else if (!listeners.has(fn))
            bindToListeners(fn);
	}

	public function unbind(fn:T->Void):Bool
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
	
	inline public function dispatch(?data:T):Void
	{
        isDispatched = true;
        this.data = data;

        if (hasListeners())
            dispatchToListeners(data);
    }

    inline public function hasListeners():Bool
    {
        return count > 0;
    }

    inline function dispatchToListeners(?data:T)
    {
		for (fn in listeners)
			fn(data);
		
		count = 0;
		untyped listeners.length = 0;
	}

	inline function bindToListeners(fn:T->Void)
	{
        if (!listeners.has(fn))
		{
			listeners.push(fn);
			++count;
		}
	}

}