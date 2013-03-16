package dust.systems.impl;

import dust.entities.api.Collection;
import dust.entities.impl.CollectionMap;
import minject.Injector;
import dust.components.Component;

class CollectionDefinitions
{
    var injector:Injector;
    var collectionMap:CollectionMap;

    var list:Array<CollectionDefinition>;

    public function new(injector:Injector, collectionMap:CollectionMap)
    {
        this.injector = injector;
        this.collectionMap = collectionMap;

        list = new Array<CollectionDefinition>();
    }

    public function add(components:Array<Class<Component>>, name:String = "")
        list.push(new CollectionDefinition(components, name))

    public function map()
    {
        for (definition in list)
            mapCollection(definition);
    }

        function mapCollection(definition:CollectionDefinition)
        {
            var config = collectionMap.map(definition.components);
            definition.collection = config.getCollection();
            injector.mapValue(Collection, definition.collection, definition.name);
        }

    public function unmap()
    {
        for (definition in list)
            injector.unmap(Collection, definition.name);
    }

}
