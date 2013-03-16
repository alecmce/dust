package ;

import dust.entities.api.Collection;
import haxe.PosInfos;
import dust.position.data.Position;

class Assert
{
    public static function fail(message:String, ?info:PosInfos)
        massive.munit.Assert.fail(message, info)

    public static function isTrue(value:Bool, ?info:PosInfos)
        massive.munit.Assert.isTrue(value, info)

    public static function isFalse(value:Bool, ?info:PosInfos)
        massive.munit.Assert.isFalse(value, info)

    public static function isNull(value:Dynamic, ?info:PosInfos)
        massive.munit.Assert.isNull(value, info)

    public static function isNotNull(value:Dynamic, ?info:PosInfos)
        massive.munit.Assert.isNotNull(value, info)

    public static function isNaN(value:Float, ?info:PosInfos)
        massive.munit.Assert.isNaN(value, info)

    public static function isNotNaN(value:Float, ?info:PosInfos)
        massive.munit.Assert.isNotNaN(value, info)

    public static function isType(value:Dynamic, type:Class<Dynamic>, ?info:PosInfos)
        massive.munit.Assert.isType(value, type, info)

    public static function isNotType(value:Dynamic, type:Class<Dynamic>, ?info:PosInfos)
        massive.munit.Assert.isNotType(value, type, info)

    public static function areEqual(expected:Dynamic, actual:Dynamic, ?info:PosInfos)
        massive.munit.Assert.areEqual(expected, actual, info)

    public static function areNotEqual(expected:Dynamic, actual:Dynamic, ?info:PosInfos)
        massive.munit.Assert.areNotEqual(expected, actual, info)

    public static function areSame(expected:Dynamic, actual:Dynamic, ?info:PosInfos)
        massive.munit.Assert.areSame(expected, actual, info)

    public static function areNotSame(expected:Dynamic, actual:Dynamic, ?info:PosInfos):Void
        massive.munit.Assert.areNotSame(expected, actual, info)

    public static function positionEquals(position:Position, x:Float, y:Float)
    {
        if (x != position.x || y != position.y)
            fail("position " + position + " does not equal (" + x + "," + y + ")");
    }

    public static function collectionCountEquals(collection:Collection, count:Int)
    {
        var n = 0;
        for (entity in collection)
            ++n;

        areEqual(count, n);
    }
}
