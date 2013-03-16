package dust.signals;

import minject.Injector;

class SignalMap
{
    var injector:Injector;

    @inject
    public function new(injector:Injector)
    {
        this.injector = injector;
    }

    public function map<T>(signal:Class<Signal<T>>, fn:T->Void)
    {
        getMappedSignalInstance(signal).bind(fn);
    }

        function getMappedSignalInstance<T>(signal:Class<Signal<T>>):Signal<T>
        {
            if (!injector.hasMapping(signal))
                injector.mapSingleton(signal);
            return injector.getInstance(signal);
        }

    public function unmap<T>(signal:Class<Signal<T>>, fn:T->Void)
    {
        getMappedSignalInstance(signal).unbind(fn);
    }

    public function mapVoid(signal:Class<SignalVoid>, fn:Void->Void)
    {
        getMappedSignalVoidInstance(signal).bind(fn);
    }

        function getMappedSignalVoidInstance(signal:Class<SignalVoid>):SignalVoid
        {
            if (!injector.hasMapping(signal))
                injector.mapSingleton(signal);
            return injector.getInstance(signal);
        }

    public function unmapVoid(signal:Class<SignalVoid>, fn:Void->Void)
    {
        getMappedSignalVoidInstance(signal).unbind(fn);
    }
}
