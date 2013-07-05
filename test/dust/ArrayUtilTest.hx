package dust;

import haxe.PosInfos;

using dust.ArrayUtil;

class ArrayUtilTest
{
    @Test public function flattens()
    {
        var list:Array<Dynamic> = ["a", ["b"]];
        Assert.arraysAreEqual(["a","b"], list.flatten());
    }

    @Test public function flattensNested()
    {
        var list:Array<Dynamic> = [["a","b"],["c"]];
        Assert.arraysAreEqual(["a","b","c"], list.flatten());
    }

    @Test public function flattensRecursively()
    {
        var list:Array<Dynamic> = [[["a","b"],"c"],"d"];
        Assert.arraysAreEqual(["a","b","c","d"], list.flatten());
    }

    @Test public function compacts()
    {
        var list:Array<Dynamic> = ["a", null, "b"];
        Assert.arraysAreEqual(["a","b"], list.compact());
    }

    @Test public function compactsFrontAndBack()
    {
        var list:Array<Dynamic> = [null, "a", null, "b", "c", null, "d", null];
        Assert.arraysAreEqual(["a","b","c","d"], list.compact());
    }

}
