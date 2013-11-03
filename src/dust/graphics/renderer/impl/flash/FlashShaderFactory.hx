package dust.graphics.renderer.impl.flash;

import com.adobe.utils.AgalMiniAssembler;
import dust.graphics.renderer.data.VertexBuffer;
import flash.geom.Matrix3D;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.VertexBuffer3D;
import flash.display3D.textures.Texture;
import flash.display3D.Context3D;
import haxe.Json;
import flash.Vector;
import flash.utils.ByteArray;
import flash.display3D.Context3DProgramType;
import com.adobe.utils.AgalMiniAssembler;
import nme.display3D.shaders.GlslToAgal;

/**
*   Derivative from original work by Ronan Sandford (@wighawag) and Jeremy Sachs (@rezmason)
*
*   https://github.com/wighawag/NMEStage3DTest
*   https://github.com/rezmason/Scourge
**/
class FlashShaderFactory
{
    public static var VERTEX = AgalMiniAssembler.VERTEX;
    public static var FRAGMENT = AgalMiniAssembler.FRAGMENT;

    @inject public var context:Context3D;
    @inject public var assembler:AgalMiniAssembler;

    var type:String;
    var source:String;

    public var nativeShader:ByteArray;

    var varTable:Map<String, String>;
    var constTable:Map<Int, Vector<Float>>;

    public function make(type:String, source:String):FlashShader
    {
        this.type = type;
        this.source = source;

        var agal = convertGLSLToAGAL();

        trace('FlashShaderFactory.make type=>$type');
        var shader = new FlashShader(context);
        shader.shader = assembleAGAL(agal.agalasm);
        shader.type = getFlashType();
        shader.varTable = makeVarTable(agal.varnames);
        shader.constTable = makeConstTable(agal.consts);
        return shader;
    }

        function getFlashType():Context3DProgramType
        {
            return type == FRAGMENT ? Context3DProgramType.FRAGMENT : Context3DProgramType.VERTEX;
        }

        function convertGLSLToAGAL():Dynamic
        {
            var agal = haxe.Json.parse(new GlslToAgal(source, type).compile());
            checkForErrors(agal.info);
            return agal;
        }

            function checkForErrors(info:String)
            {
                if (info.indexOf('error') == -1)
                    return;

                var buffer = new Array<String>();
                buffer.push('GlslToAgal Error');
                buffer.push(info);
                buffer.push('type: $type');
                buffer.push('source: $source');
                throw buffer.join('\n');
            }

        function makeVarTable(sVars:Dynamic<String>):Map<String, String>
        {
            varTable = new Map<String, String>();
            for (name in Reflect.fields(sVars))
                varTable[name] = cast Reflect.field(sVars, name);
            return varTable;
        }

        function makeConstTable(sConsts:Dynamic<Array<Float>>):Map<Int, Vector<Float>>
        {
            var constTable = new Map<Int, Vector<Float>>();
            for (name in Reflect.fields(sConsts))
                constTable[getRegisterIndex(name)] = Vector.ofArray(Reflect.field(sConsts, name));
            return constTable;
        }

        function assembleAGAL(shaderSource:String):ByteArray
        {
            assembler.assemble(type, shaderSource);
            return assembler.agalcode;
        }

    public function setup(context3D:Context3D)
    {
        for (index in constTable.keys())
            setUniformFromVector(context3D, index, constTable[index]);
    }

    public function setUniformFromMatrix(context3D:Context3D, index:Int, matrix:Matrix3D, transposedMatrix:Bool = false)
    {
        context3D.setProgramConstantsFromMatrix(getFlashType(), index, matrix, transposedMatrix);
    }

    public function setUniformFromByteArray(context3D, index:Int, data:ByteArray, byteArrayOffset:Int)
    {
        context3D.setProgramConstantsFromByteArray(getFlashType(), index, 1, data, byteArrayOffset);
    }

    public function setUniformFromVector(context3D:Context3D, index:Int, vector:Vector<Float>)
    {
        context3D.setProgramConstantsFromVector(getFlashType(), index, vector, 1);
    }

    public function getRegisterIndex(name:String):Int
    {
        var registerName:String = varTable[name];
        if (registerName == null)
            registerName = name;
        return Std.parseInt(registerName.substr(2)); //vc#, fc#, fs#
    }

    public function setTextureAt(context3D:Context3D, index:Int, texture:Texture)
    {
        context3D.setTextureAt(index, texture);
    }

    public function setVertexBufferAt(context3D:Context3D, index:Int, vertexBuffer:VertexBuffer, bufferOffset:Int, format:Context3DVertexBufferFormat)
    {
        var buffer = cast (vertexBuffer, FlashVertexBuffer).buffer;
        context3D.setVertexBufferAt(index, buffer, bufferOffset, format);
    }

    public function hasVar(name:String):Bool
    {
        return varTable.exists(name);
    }
}
