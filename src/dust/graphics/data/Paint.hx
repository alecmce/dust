package dust.graphics.data;

import dust.camera.data.Camera;
import dust.components.Component;
import dust.gui.data.Color;
import nme.display.Graphics;

class Paint
{
	public var line:Color;
    public var fill:Color;
    public var lineWidth:Int;

	public function new()
	{
		line = new Color(0, 1.0);
        fill = new Color(0, 0.0);
        lineWidth = -1;
    }

    public function setLine(width:Int, rgb:Int = 0, alpha:Float = 1.0):Paint
    {
        lineWidth = width;
        line.set(rgb, alpha);
        return this;
    }

    public function setFill(rgb:Int, alpha:Float = 1.0):Paint
    {
        fill.set(rgb, alpha);
        return this;
    }

	public function paint<T>(data:T, graphics:Graphics, block:T->Graphics->Void)
	{
		setupLine(graphics);
		setupFill(graphics);
        block(data, graphics);
        endFill(graphics);
	}

    inline public function setupLine(graphics:Graphics)
    {
        if (lineWidth >= 0)
            graphics.lineStyle(lineWidth, line.rgb, line.alpha);
        else
            graphics.lineStyle();
    }

    inline public function setupFill(graphics:Graphics)
    {
        var alpha = fill.alpha;
        if (alpha > 0)
            graphics.beginFill(fill.rgb, alpha);
    }

	inline public function endFill(graphics:Graphics)
	{
        if (fill.alpha > 0)
    		graphics.endFill();
	}

    public function toString():String
    {
        return "[Color width=" + lineWidth + ", line=#" + line.toString() + ", fill=#" + fill.toString() + "]";
    }

}