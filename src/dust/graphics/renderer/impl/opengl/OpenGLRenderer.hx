package dust.graphics.renderer.impl.opengl;

import openfl.gl.GL;
import openfl.display.OpenGLView;
import flash.geom.Rectangle;
import dust.graphics.renderer.control.Renderer;

typedef ReadbackData = #if js openfl.utils.UInt8Array #else flash.utils.ByteArray #end;

class OpenGLRenderer implements Renderer
{
    @inject public var view:OpenGLView;

    var renderCalls:Array<Int->Int->Void>;

    public function new()
    {
        renderCalls = new Array<Int->Int->Void>();
    }

    public function addRenderCall(call:Int->Int->Void)
    {
        view.render = onRender;
        renderCalls.push(call);
    }

    public function removeRenderCall(call:Int->Int->Void)
    {
        renderCalls.remove(call);
    }

        function onRender(rect:Rectangle)
        {
            var x:Int = Std.int(rect.x);
            var y:Int = Std.int(rect.y);
            var w:Int = Std.int(rect.width);
            var h:Int = Std.int(rect.height);
            GL.viewport(x, y, w, h);

            for (fn in renderCalls)
                fn(w, h);
        }
}
