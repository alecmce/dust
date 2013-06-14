package dust.entities.api;

import dust.components.Bitfield;
import dust.components.Component;

interface Entity
{
	var id:Int;
    var bitfield:Bitfield;
    var isChanged:Bool;
    var isReleased:Bool;

    function add(component:Component):Void;
    function remove<T>(type:Class<T>):Bool;
    function satisfies(bitfield:Bitfield):Bool;
    function dispose():Void;
    function removeAll():Void;

    function cacheDeletions():Void;
    function removeCachedDeletions():Void;

    function get<T>(type:Class<T>):T;
    function has(type:Class<Dynamic>):Bool;
	function iterator():Iterator<Component>;
    function toString():String;
}
