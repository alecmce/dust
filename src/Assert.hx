package;

import dust.geom.data.Position;
import haxe.PosInfos;

class Assert
{
    public static function addAssertion()
        massive.munit.Assert.assertionCount++

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

    public static function areNotSame(expected:Dynamic, actual:Dynamic, ?info:PosInfos)
        massive.munit.Assert.areNotSame(expected, actual, info)

    public static function positionEquals(position:Position, x:Float, y:Float)
    {
        if (x != position.x || y != position.y)
            fail("position " + position + " does not equal (" + x + "," + y + ")");
    }

    public static function listCountEquals(iterator:Iterator<Dynamic>, count:Int)
    {
        var n = 0;
        while (iterator.hasNext())
        {
            ++n;
            iterator.next();
        }

        areEqual(count, n);
    }

    public static function arraysAreEqual(expected:Array<Dynamic>, actual:Array<Dynamic>, ?info:PosInfos)
    {
        var areEqual = actual.length == expected.length;

        if (areEqual)
            for (i in 0...actual.length)
                areEqual = areEqual && actual[i] == expected[i];

        areEqual ? addAssertion() : Assert.fail("Value " + actual +" was not equal to expected value " + expected, info);
    }

    public static function listIncludes(iterator:Iterator<Dynamic>, actual:Dynamic, ?info:PosInfos)
    {
        var isIncluded = false;
        while (iterator.hasNext())
            isIncluded = iterator.next() == actual || isIncluded;

        isIncluded ? addAssertion() : fail("expected " + actual + " in list, but was not found");
    }

    public static function listExcludes(iterator:Iterator<Dynamic>, actual:Dynamic, ?info:PosInfos)
    {
        var isIncluded = false;
        while (iterator.hasNext())
            isIncluded = iterator.next() == actual || isIncluded;

        isIncluded ? fail(actual + " was included in list, but should not be") : addAssertion();
    }
}
