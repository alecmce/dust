package dust.inspector.systems;

import dust.inspector.control.UIInspectorFactory;
import dust.entities.Entities;
import dust.gui.data.UIView;
import dust.inspector.data.Inspector;
import dust.gui.data.HAlign;
import dust.gui.data.VAlign;
import dust.gui.data.Alignment;
import dust.app.data.App;
import dust.geom.data.Position;
import flash.display.DisplayObjectContainer;
import dust.inspector.ui.UIInspector;
import haxe.macro.Expr.Field;
import dust.inspector.data.Inspector;
import dust.entities.Entity;
import dust.entities.Entity;
import dust.collections.api.CollectionListeners;

// written to accept/expect trigger from either Inspector or InspectorFocus, per InspectorConfig
class InspectorListeners implements CollectionListeners
{
    @inject public var app:App;
    @inject public var entities:Entities;
    @inject public var factory:UIInspectorFactory;

    public function onEntityAdded(entity:Entity)
    {
        var inspector = getInspector(entity);
        populateInspector(entity, inspector);
        inspector.ui = makeUIInspector(entity);
    }

        function getInspector(entity:Entity):Inspector
        {
            return if (entity.has(Inspector))
                entity.get(Inspector);
            else
                makeInspector(entity);
        }

            function makeInspector(entity:Entity):Inspector
            {
                var inspector = new Inspector();
                entity.add(inspector);
                return inspector;
            }

        function populateInspector(entity:Entity, inspector:Inspector)
        {
            for (component in entity)
            {
                var type = getType(entity, component);
                if (type != Inspector && type != null)
                {
                    var fields = Type.getInstanceFields(type);
                    for (field in fields)
                    {
                        if (!Reflect.isFunction(Reflect.field(component, field)))
                            addField(inspector, type, field);
                    }
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

            function addField(inspector:Inspector, component:Class<Dynamic>, field:String)
            {
                inspector.add(component, field);
            }

        function makeUIInspector(target:Entity):Entity
        {
            var entity = entities.require();
            entity.addAsType(factory.make(target), UIView);
            entity.add(new Position(app.stageWidth, app.stageHeight));
            entity.add(new Alignment(HAlign.RIGHT, VAlign.BOTTOM));
            return entity;
        }

    public function onEntityRemoved(entity:Entity)
    {
        entity.remove(Inspector);
        entity.get(Inspector).ui.dispose();
    }
}
