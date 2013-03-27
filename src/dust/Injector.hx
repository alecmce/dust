package dust;

class Injector
{
    var wrapped:minject.Injector;

    public function new(parent:Injector = null)
    {
        wrapped = new minject.Injector();
        if (parent != null)
            wrapped.parentInjector = parent.wrapped;
    }

    inline public function mapValue(whenAskedFor:Class<Dynamic>, useValue:Dynamic, ?named:String = ''):Injector
    {
        if (!wrapped.hasMapping(whenAskedFor))
            wrapped.mapValue(whenAskedFor, useValue, named);
        return this;
    }

    inline public function mapClass(whenAskedFor:Class<Dynamic>, instantiateClass:Class<Dynamic>, ?named:String=''):Injector
    {
        if (!wrapped.hasMapping(whenAskedFor))
            wrapped.mapClass(whenAskedFor, instantiateClass, named);
        return this;
    }

    inline public function mapSingleton(whenAskedFor:Class<Dynamic>, ?named:String=''):Injector
    {
        if (!wrapped.hasMapping(whenAskedFor))
            wrapped.mapSingleton(whenAskedFor, named);
        return this;
    }

    inline public function mapSingletonOf(whenAskedFor:Class<Dynamic>, useSingletonOf:Class<Dynamic>, ?named:String=''):Injector
    {
        if (!wrapped.hasMapping(whenAskedFor))
            wrapped.mapSingletonOf(whenAskedFor, useSingletonOf, named);
        return this;
    }

    inline public function remapValue(whenAskedFor:Class<Dynamic>, useValue:Dynamic, ?named:String = ''):Injector
    {
        unmap(whenAskedFor, named);
        wrapped.mapValue(whenAskedFor, useValue, named);
        return this;
    }

    inline public function remapClass(whenAskedFor:Class<Dynamic>, instantiateClass:Class<Dynamic>, ?named:String=''):Injector
    {
        unmap(whenAskedFor, named);
        wrapped.mapClass(whenAskedFor, instantiateClass, named);
        return this;
    }

    inline public function remapSingleton(whenAskedFor:Class<Dynamic>, ?named:String=''):Injector
    {
        unmap(whenAskedFor, named);
        wrapped.mapSingleton(whenAskedFor, named);
        return this;
    }

    inline public function remapSingletonOf(whenAskedFor:Class<Dynamic>, useSingletonOf:Class<Dynamic>, ?named:String=''):Injector
    {
        unmap(whenAskedFor, named);
        wrapped.mapSingletonOf(whenAskedFor, useSingletonOf, named);
        return this;
    }

    inline public function hasMapping(theClass:Class<Dynamic>, ?named:String = ''):Bool
    {
        return wrapped.hasMapping(theClass, named);
    }

    inline public function unmap(theClass:Class<Dynamic>, ?named:String = '')
    {
        if (wrapped.hasMapping(theClass, named))
            wrapped.unmap(theClass, named);
    }

    inline public function injectInto(target:Dynamic)
    {
        wrapped.injectInto(target);
    }

    inline public function instantiate<T>(theClass:Class<T>):T
    {
        return wrapped.instantiate(theClass);
    }

    inline public function getInstance<T>(ofClass:Class<T>, ?named:String=''):T
    {
        return wrapped.getInstance(ofClass, named);
    }
}
