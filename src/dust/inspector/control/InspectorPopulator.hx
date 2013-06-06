package dust.inspector.control;
import dust.components.Component;
import dust.inspector.data.Inspector;
import dust.entities.api.Entity;

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

    function getType(entity:Entity, component:Component)
    {
        var type = Type.getClass(component);
        if (entity.has(type))
            return type;

        while (type != Component)
        {
            type = cast Type.getSuperClass(type);
            if (entity.has(type) && entity.get(type) == component)
                return type;
        }

        return null;
    }

    function addField(inspector:Inspector, component:Class<Component>, field:String)
    {
        inspector.add(component, field);
    }
}
