package dust.multitouch.data;


class GestureAction
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
