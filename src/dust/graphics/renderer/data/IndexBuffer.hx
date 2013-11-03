package dust.graphics.renderer.data;

import dust.graphics.data.IndexTriple;

interface IndexBuffer
{
    var count:Int;

    function set(index:Int, value:Int):Void;
    function setTriangle(index:Int, zero:Int, triple:IndexTriple):Void;
    function get(index:Int):Int;

    function update():Void;
}
