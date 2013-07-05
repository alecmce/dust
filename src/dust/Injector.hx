package dust;

import minject.Injector.InjecteeDescription;
import minject.InjectionConfig;

class Injector
{
    var wrapped:minject.Injector;

    public function new(parentInjector:Injector = null)
    {
        wrapped = new minject.Injector();
        wrapped.parentInjector = parentInjector != null ? parentInjector.wrapped : null;
    }

    public function mapValue(whenAskedFor:Class<Dynamic>, useValue:Dynamic, ?named:String = ''):Injector
    {
        wrapped.mapValue(whenAskedFor, useValue, named);
        return this;
    }

    public function mapClass(whenAskedFor:Class<Dynamic>, instantiateClass:Class<Dynamic>, ?named:String=''):Injector
    {
        wrapped.mapClass(whenAskedFor, instantiateClass, named);
        return this;
    }

    public function mapSingleton(whenAskedFor:Class<Dynamic>, ?named:String=''):Injector
    {
        wrapped.mapSingleton(whenAskedFor, named);
        return this;
    }

    public function mapSingletonOf(whenAskedFor:Class<Dynamic>, useSingletonOf:Class<Dynamic>, ?named:String=''):Injector
    {
        wrapped.mapSingletonOf(whenAskedFor, useSingletonOf, named);
        return this;
    }

    public function reset():Injector
    {
        untyped wrapped.injectionConfigs = new haxe.ds.StringMap<InjectionConfig>();
        untyped wrapped.injecteeDescriptions = new minject.Injector.ClassHash<InjecteeDescription>();
        return this;
    }

    public function hasMapping(forClass:Class<Dynamic>, ?named:String = ''):Bool
    {
        return wrapped.hasMapping(forClass, named);
    }

    public function unmap(forClass:Class<Dynamic>, ?named:String = '')
    {
        wrapped.unmap(forClass, named);
    }

    public function injectInto(target:Dynamic)
    {
        wrapped.injectInto(target);
    }

    public function instantiate<T>(forClass:Class<T>):T
    {
        return wrapped.instantiate(forClass);
    }

    public function getInstance<T>(ofClass:Class<T>, ?named:String=''):T
    {
        return wrapped.getInstance(ofClass, named);
    }
}
