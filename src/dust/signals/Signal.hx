package dust.signals;

using Lambda;

class Signal<T>
{
	public var count(default, null):Int;

	var many:List<T->Void>;
	var once:List<T->Void>;

	public function new()
	{
		count = 0;
		many = new List<T->Void>();
		once = new List<T->Void>();
	}

	public function bind(fn:T->Void):Bool
	{
		if (once.has(fn))
			throw "attempted to bind a method that has already been bindOnced";

		return bindTo(fn, many);
	}

	public function bindOnce(fn:T->Void):Bool
	{
		if (many.has(fn))
			throw "attempted to bindOnce a method that has already been binded";

		return bindTo(fn, once);
	}

	public function unbind(fn:T->Void):Bool
	{
		return unbindFrom(fn, many) || unbindFrom(fn, once);
	}

	public function unbindAll():Void
	{
		count = 0;
		untyped once.length = 0;
		untyped many.length = 0;
	}
	
	inline public function dispatch(?data:T):Void
	{
        if (hasListeners())
            dispatchToListeners(data);
    }

    inline public function hasListeners():Bool
    {
        return count > 0;
    }

    inline function dispatchToListeners(?data:T)
    {
		for (fn in many)
			fn(data);

		for (fn in once)
			fn(data);
		
		count -= once.length;
		untyped once.length = 0;
	}

	inline function bindTo(fn:T->Void, array:List<T->Void>):Bool
	{
		var isNewBind = !array.has(fn);

		if (isNewBind)
		{
			array.push(fn);
			++count;
		}
		
		return isNewBind;
	}

	inline function unbindFrom(fn:T->Void, array:List<T->Void>):Bool
	{
		var isOldBind = array.has(fn);
		if (isOldBind)
		{
			array.remove(fn);
			--count;
		}
		
		return isOldBind;
	}

}