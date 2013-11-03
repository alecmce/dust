package dust.graphics.renderer.impl.flash;

import dust.graphics.renderer.control.Renderer;
import dust.graphics.renderer.impl.flash.FlashTextureFactory;
import flash.geom.Matrix;
import flash.display3D.Context3DTextureFormat;
import dust.graphics.renderer.data.RendererTexture;
import flash.display.BitmapData;
import flash.display3D.Context3D;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Rectangle;

typedef ReadbackData = flash.utils.ByteArray;

class FlashRenderer implements Renderer
{
    var context:Context3D;
    var stage:Stage;
    var renderCalls:Array<Int->Int->Void>;

    var width:Int;
    var height:Int;
    var stageRect:Rectangle;

    @inject public function new(context:Context3D, stage:Stage)
    {
        this.context = context;
        this.stage = stage;
        this.renderCalls = new Array<Int->Int->Void>();
        init();
    }

        function init()
        {
            width = stage.stageWidth;
            height = stage.stageHeight;
            stageRect = new Rectangle(0, 0, width, height);
            stage.addEventListener(Event.RESIZE, onResize);
            stage.addEventListener(Event.ENTER_FRAME, onIterate);
        }

        function onResize(_)
        {
            width = stage.stageWidth;
            height = stage.stageHeight;
            stageRect.width = width;
            stageRect.height = height;
        }

        function onIterate(_)
        {
            for (fn in renderCalls)
                fn(width, height);
        }

    public function addRenderCall(call:Int->Int->Void)
    {
        renderCalls.push(call);
    }

    public function removeRenderCall(call:Int->Int->Void)
    {
        renderCalls.remove(call);
    }
}