package dust.graphics.renderer.data;

import flash.geom.Matrix3D;
import dust.gui.data.Color;

interface Program
{
    var cullFaces:CullFaces;
    var depthTest:Bool;
    var zNear:Float;
    var zFar:Float;

    function setShaderParameter(name:String, matrix:Matrix3D, transposed:Bool = false):Void;
    function setTexture(name:String, texture:RendererTexture):Void;
    
    function activate():Void;
    function clear(color:Color):Void;
    function setVertexBuffer(buffer:VertexBuffer):Void;
    function drawTriangles(buffer:IndexBuffer, firstIndex:Int = 0, numTriangles:Int = 0):Void;
    function setOutputBuffer(buffer:OutputBuffer):Void;
    function finishOutputBuffer(buffer:OutputBuffer):Void;
}
