package dust.systems;

interface System
{
	function start():Void;
	function stop():Void;
    function iterate(deltaTime:Float):Void;
}