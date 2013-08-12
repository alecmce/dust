package dust.collections.control;

import dust.collections.data.CollectionListenersList;
import dust.collections.api.CollectionListeners;
import dust.Injector;

class CollectionListenersMap
{
    var injector:Injector;
    var types:Array<Class<CollectionListeners>>;

    @inject public function new(injector:Injector)
    {
        this.injector = injector;
    }

    public function addListener(type:Class<CollectionListeners>)
    {
        if (types == null)
            types = new Array<Class<CollectionListeners>>();
        types.push(type);
    }

    public function make():CollectionListenersList
    {
        return new CollectionListenersList(makeListeners());
    }

        function makeListeners():Array<CollectionListeners>
        {
            var list = new Array<CollectionListeners>();
            if (types != null)
                populateList(list);
            return list;
        }

        function populateList(list:Array<CollectionListeners>)
        {
            for (type in types)
            {
                var instance = injector.instantiate(type);
                list.push(instance);
            }
        }
}
