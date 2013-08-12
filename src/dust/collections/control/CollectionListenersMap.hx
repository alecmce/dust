package dust.collections.control;

import dust.collections.data.SimpleCollectionListeners;
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

    public function make():SimpleCollectionListeners
    {
        return new SimpleCollectionListeners(makeListeners());
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
