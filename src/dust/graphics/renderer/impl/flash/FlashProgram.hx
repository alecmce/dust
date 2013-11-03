package dust.graphics.renderer.impl.flash;

import dust.gui.data.Color;
import dust.graphics.renderer.data.CullFaces;
import flash.display3D.Context3DTriangleFace;
import dust.graphics.renderer.data.OutputBuffer;
import dust.graphics.renderer.impl.flash.FlashIndexBufferFactory.FlashIndexBuffer;
import dust.graphics.renderer.data.IndexBuffer;
import dust.graphics.renderer.impl.flash.FlashOutputBufferFactory.FlashOutputBuffer;
import flash.display3D.Context3D;
import dust.graphics.renderer.data.VertexBuffer;
import flash.display3D.Context3DVertexBufferFormat;
import flash.geom.Matrix3D;
import dust.graphics.renderer.data.RendererTexture;
import dust.graphics.renderer.impl.flash.FlashShader;
import flash.display3D.Program3D;
import flash.display3D.Context3D;
import dust.graphics.renderer.data.Program;

class FlashProgram implements Program
{
    static var sizes:Array<Context3DVertexBufferFormat> = [BYTES_4,FLOAT_1,FLOAT_2,FLOAT_3,FLOAT_4];

    public var cullFaces:CullFaces;
    public var depthTest:Bool;
    public var zNear:Float = -1000;
    public var zFar:Float = 1000;

    var context:Context3D;
    var program:Program3D;
    var vertexShader:FlashShader;
    var fragmentShader:FlashShader;

    var vertexIndices:RetrieveMap<Int>;
    var fragmentIndices:RetrieveMap<Int>;

    var outputBuffer:FlashOutputBuffer;

    public function new(context:Context3D, program:Program3D, vertexShader:FlashShader, fragmentShader:FlashShader)
    {
        this.program = program;
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;

        vertexIndices = new RetrieveMap<Int>();
        fragmentIndices = new RetrieveMap<Int>();
    }

    public function setShaderParameter(name:String, matrix:Matrix3D, transposed:Bool = false)
    {
        var index = vertexIndices.get(name, vertexShader.getRegisterIndex);
        vertexShader.setUniformFromMatrix(index, matrix, transposed);
    }

    public function setTexture(name:String, texture:RendererTexture)
    {
        var index = fragmentIndices.get(name, fragmentShader.getRegisterIndex);
        fragmentShader.setTextureAt(index, cast texture);
    }

    public function setVertexBuffer(buffer:VertexBuffer)
    {
        for (structure in buffer.structure)
        {
            var index = vertexIndices.get(structure.name, vertexShader.getRegisterIndex);
            vertexShader.setVertexBufferAt(index, buffer, structure.offset, sizes[structure.size]);
        }
    }

    public function activate()
    {
        context.setProgram(program);
        vertexShader.setup();
        fragmentShader.setup();

        if (cullFaces != CullFaces.NONE)
            context.setCulling(parseCullFaces());
        else
            context.setCulling(Context3DTriangleFace.NONE);
    }

        function parseCullFaces():Context3DTriangleFace
        {
            return switch (cullFaces)
            {
                case CullFaces.BACK:
                    Context3DTriangleFace.BACK;
                case CullFaces.FRONT:
                    Context3DTriangleFace.BACK;
                case CullFaces.FRONT_AND_BACK:
                    Context3DTriangleFace.FRONT_AND_BACK;
                default:
                    Context3DTriangleFace.NONE;
            }
        }

    public function clear(color:Color)
    {
        var red   = color.getRed();
        var green = color.getGreen();
        var blue  = color.getBlue();
        var alpha = color.getAlpha();
        context.clear(red, green, blue, alpha);
    }

    public function drawTriangles(buffer:IndexBuffer, firstIndex:Int = 0, numTriangles:Int = 0)
    {
        if (numTriangles == 0)
            numTriangles = Std.int(buffer.count / 3);

        var actual = cast (buffer, FlashIndexBuffer).buffer;
        context.drawTriangles(actual, firstIndex, numTriangles);
    }

    public function setOutputBuffer(buffer:OutputBuffer)
    {
        // noop
    }

    public function finishOutputBuffer(buffer:OutputBuffer)
    {
        if (outputBuffer == null)
            context.present();
        else
            context.drawToBitmapData(outputBuffer.bitmapData);
    }
}
