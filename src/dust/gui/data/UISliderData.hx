package dust.gui.data;

class UISliderData
{
    public static var DEFAULT_WIDTH = 200;
    public static var DEFAULT_HEIGHT = 16;
    public static var DEFAULT_HANDLE_SIZE = 12;
    public static var DEFAULT_HANDLE_COLOR = 0x666666;
    public static var DEFAULT_BACKGROUND_COLOR = 0x333333;

    public var update:Float->Void;
    public var value:Float;
    public var min:Float;
    public var max:Float;

    public var width:Int;
    public var height:Int;
    public var handleSize:Int;
    public var backgroundColor:Int;
    public var handleColor:Int;

    public function new(update:Float->Void, value:Float, min:Float, max:Float)
    {
        this.update = update;
        this.value = value;
        this.min = min;
        this.max = max;

        this.width = DEFAULT_WIDTH;
        this.height = DEFAULT_HEIGHT;
        this.handleSize = DEFAULT_HANDLE_SIZE;
        this.handleColor = DEFAULT_HANDLE_COLOR;
        this.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    }

    public function setWidth(width:Int):UISliderData
    {
        this.width = width;
        return this;
    }

    public function setHeight(height:Int):UISliderData
    {
        this.height = height;
        return this;
    }
}
