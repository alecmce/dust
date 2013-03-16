package dust.signals;

import haxe.PosInfos;

using Lambda;

class SignalVoid
{
	public var count(default, null):Int;

	var many:Array<Void->Void>;
	var once:Array<Void->Void>;

	public function new()
	{
		count = 0;
		many = new Array<Void->Void>();
		once = new Array<Void->Void>();
	}

	inline public function hasListeners():Bool
	{
		return count > 0;
	}

	public function bind(fn:Void->Void):Bool
	{
		if (once.has(fn))
			throw "attempted to bind a method that has already been bindOnced";

		return bindTo(fn, many);
	}

	public function bindOnce(fn:Void->Void):Bool
	{
		if (many.has(fn))
			throw "attempted to bindOnce a method that has already been binded";

		return bindTo(fn, once);
	}

	public function unbind(fn:Void->Void):Bool
	{
		return unbindFrom(fn, many) || unbindFrom(fn, once);
	}

	public function unbindAll():Void
	{
		count = 0;
		untyped once.length = 0;
		untyped many.length = 0;
	}
	
	public function dispatch()
	{
        if (hasListeners())
            dispatchToListeners();
    }

    inline function dispatchToListeners()
    {
		for (fn in many)
			fn();

		for (fn in once)
			fn();
		
		count -= once.length;
		untyped once.length = 0;
	}

	inline function bindTo(fn:Void->Void, array:Array<Void->Void>):Bool
	{
		var isNewBind = !array.has(fn);

		if (isNewBind)
		{
			array.push(fn);
			++count;
		}
		
		return isNewBind;
	}

	inline function unbindFrom(fn:Void->Void, array:Array<Void->Void>):Bool
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