package dust.inspector.data;

import dust.entities.Entity;

class Inspector
{
    public var ui:Entity;

    var typeHash:TypeHash;

    public function new()
    {
        this.typeHash = new TypeHash();
    }

    public function add(type:Class<Dynamic>, field:String)
    {
        var componentID = (cast type).ID;
        var fieldHash = getTypeHash(componentID);
        fieldHash.set(field, new InspectedField(type, field));
    }

        function getTypeHash(componentID:Int):FieldHash
        {
            return if (typeHash.exists(componentID))
                typeHash.get(componentID);
            else
                makeTypeHash(componentID);
        }

        function makeTypeHash(componentID:Int):FieldHash
        {
            var fieldHash = new FieldHash();
            typeHash.set(componentID, fieldHash);
            return fieldHash;
        }

    public function has(type:Class<Dynamic>, field:String):Bool
    {
        var componentID = (cast type).ID;
        return typeHash.exists(componentID) && typeHash.get(componentID).exists(field);
    }

    public function update(entity:Entity)
    {
        for (field in this)
            field.update(entity);
    }

    public function iterator():Iterator<InspectedField>
        return new InspectorIterator(typeHash)
}
