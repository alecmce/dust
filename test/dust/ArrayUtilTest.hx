package dust;

import massive.munit.Assert;
import haxe.PosInfos;
import massive.munit.Assert;
import massive.munit.Assert;

using dust.ArrayUtil;

class ArrayUtilTest
{
    @Test public function flattens()
    {
        var list = ["a", ["b"]];
        assertArraysAreEqual(list.flatten(), ["a","b"]);
    }

    @Test public function flattensNested()
    {
        var list = [["a","b"],["c"]];
        assertArraysAreEqual(list.flatten(), ["a","b","c"]);
    }

    @Test public function flattensRecursively()
    {
        var list = [[["a","b"],"c"],"d"];
        assertArraysAreEqual(list.flatten(), ["a","b","c","d"]);
    }

    @Test public function compacts()
    {
        var list = ["a", null, "b"];
        assertArraysAreEqual(list.compact(), ["a","b"]);
    }

    @Test public function compactsFrontAndBack()
    {
        var list = [null, "a", null, "b", "c", null, "d", null];
        assertArraysAreEqual(list.compact(), ["a","b","c","d"]);
    }

    private function assertArraysAreEqual(actual:Array<Dynamic>, expected:Array<Dynamic>, ?info:PosInfos)
    {
        var areEqual = actual.length == expected.length;

        if (areEqual)
            for (i in 0...actual.length)
                areEqual = areEqual && actual[i] == expected[i];

        if (areEqual)
            Assert.assertionCount++;
        else
            Assert.fail("Value [" + actual +"] was not equal to expected value [" + expected + "]", info);
    }

}
