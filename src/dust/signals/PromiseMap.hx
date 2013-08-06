package dust.signals;

import dust.Injector;

class PromiseMap
{
    var injector:Injector;

    @inject public function new(injector:Injector)
    {
        this.injector = injector;
    }

    public function map<T>(promise:Class<Promise<T>>, fn:T->Void)
    {
        getMappedPromiseInstance(promise).bind(fn);
    }

        function getMappedPromiseInstance<T>(promise:Class<Promise<T>>):Promise<T>
        {
            if (!injector.hasMapping(promise))
                injector.mapSingleton(promise);
            return injector.getInstance(promise);
        }

    public function unmap<T>(promise:Class<Promise<T>>, fn:T->Void)
    {
        getMappedPromiseInstance(promise).unbind(fn);
    }

    public function mapVoid(promise:Class<PromiseVoid>, fn:Void->Void)
    {
        getMappedPromiseVoidInstance(promise).bind(fn);
    }

        function getMappedPromiseVoidInstance(promise:Class<PromiseVoid>):PromiseVoid
        {
            if (!injector.hasMapping(promise))
                injector.mapSingleton(promise);
            return injector.getInstance(promise);
        }

    public function unmapVoid(promise:Class<PromiseVoid>, fn:Void->Void)
    {
        getMappedPromiseVoidInstance(promise).unbind(fn);
    }
}
