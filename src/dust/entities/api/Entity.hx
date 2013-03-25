package dust.entities.api;

import dust.components.Bitfield;
import dust.components.Component;

interface Entity
{
	var id:Int;
    var isChanged:Bool;
    var isReleased:Bool;

    function add(component:Component):Bool;
    function addAsType(component:Component, asType:Class<Component>):Bool;
    function remove<T>(type:Class<T>):Bool;
    function satisfies(bitfield:Bitfield):Bool;
    function dispose():Void;
    function removeAll():Void;
    function update():Void;
    function get<T>(type:Class<T>):T;
    function has(type:Class<Dynamic>):Bool;
	function iterator():Iterator<Component>;
    function toString():String;
}
