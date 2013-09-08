package dust.inspector.control;
import dust.inspector.data.Inspector;
import dust.entities.Entity;

class InspectorPopulator
{
    public function new() {}

    public function populate(entity:Entity, inspector:Inspector)
    {
        for (component in entity)
        {
            var type = getType(entity, component);
            if (type != Inspector && type != null)
            {
                for (field in Reflect.fields(type))
                    addField(inspector, type, field);
            }
        }
    }

    function getType<T>(entity:Entity, component:Dynamic):Class<T>
    {
        var type = Type.getClass(component);
        return entity.has(type) ? type : null;
    }

    function addField(inspector:Inspector, component:Class<Dynamic>, field:String)
    {
        inspector.add(component, field);
    }
}
