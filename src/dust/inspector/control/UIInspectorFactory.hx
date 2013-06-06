package dust.inspector.control;

import dust.inspector.ui.UIInspector;
import dust.inspector.ui.UIInspectedField;
import dust.entities.api.Entity;

class UIInspectorFactory
{
    @inject public var fieldFactory:UIInspectedFieldFactory;

    public function make(target:Entity):UIInspector
    {
        return new UIInspector(target, fieldFactory);
    }
}
