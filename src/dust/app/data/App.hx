package dust.app.data;

class App
{
    public var stageWidth:Int;
    public var stageHeight:Int;
    public var target:AppTarget;
    public var isMultiTouch:Bool;
    public var hasGestures:Bool;
    public var supportedGestures:Array<String>;

    public function new() {}

    public function isRetina():Bool
        return target == AppTarget.IPAD_RETINA;
}
