package dust.graphics.renderer.impl.flash;

import dust.graphics.renderer.data.VertexBuffer;
import flash.geom.Matrix3D;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.VertexBuffer3D;
import flash.display3D.textures.Texture;
import flash.display3D.Context3D;
import flash.Vector;
import flash.utils.ByteArray;
import flash.display3D.Context3DProgramType;
import nme.display3D.shaders.GlslToAgal;

/**
*   Derivative from original work by Ronan Sandford (@wighawag) and Jeremy Sachs (@rezmason)
*
*   https://github.com/wighawag/NMEStage3DTest
*   https://github.com/rezmason/Scourge
**/
class FlashShader
{
    public var shader:ByteArray;
    public var type:Context3DProgramType;
    public var varTable:Map<String, String>;
    public var constTable:Map<Int, Vector<Float>>;

    var context:Context3D;

    public function new(context:Context3D)
    {
        this.context = context;
    }

    public function setup()
    {
        for (index in constTable.keys())
            setUniformFromVector(index, constTable.get(index));
    }

    public function setUniformFromMatrix(index:Int, matrix:Matrix3D, transposedMatrix:Bool = false)
    {
        context.setProgramConstantsFromMatrix(type, index, matrix, transposedMatrix);
    }

    public function setUniformFromByteArray(index:Int, data:ByteArray, byteArrayOffset:Int)
    {
        context.setProgramConstantsFromByteArray(type, index, 1, data, byteArrayOffset);
    }

    public function setUniformFromVector(index:Int, vector:Vector<Float>)
    {
        context.setProgramConstantsFromVector(type, index, vector, 1);
    }

    public function getRegisterIndex(name:String):Int
    {
        var registerName:String = varTable.get(name);
        if (registerName == null)
            registerName = name;
        return Std.parseInt(registerName.substr(2)); //vc#, fc#, fs#
    }

    public function setTextureAt(index:Int, texture:Texture)
    {
        context.setTextureAt(index, texture);
    }

    public function setVertexBufferAt(index:Int, vertexBuffer:VertexBuffer, bufferOffset:Int, format:Context3DVertexBufferFormat)
    {
        var buffer = cast (vertexBuffer, FlashVertexBuffer).buffer;
        context.setVertexBufferAt(index, buffer, bufferOffset, format);
    }

    public function hasVar(name:String):Bool
    {
        return varTable.exists(name);
    }
}
