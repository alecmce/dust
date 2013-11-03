package dust.graphics.renderer.data;

interface VertexBuffer
{
    var vertexCount:Int;
    var perVertex:Int;
    var structure:Array<VertexBufferStructure>;

    function set(index:Int, value:Float):Void;
    function setVertex(index:Int, values:Array<Float>):Void;
    function get(index:Int):Float;
}
