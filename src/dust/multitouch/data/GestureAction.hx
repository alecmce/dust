package dust.multitouch.data;

import dust.components.Component;

class GestureAction extends Component
{
    public var start:Void->Void;
    public var update:Void->Void;
    public var end:Void->Void;

    public function new()
    {
        start = emptyMethod;
        update = emptyMethod;
        end = emptyMethod;
    }

    function emptyMethod() {}
}
