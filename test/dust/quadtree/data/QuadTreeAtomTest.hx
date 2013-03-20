package dust.quadtree.data;

import dust.geom.data.Position;

class QuadTreeAtomTest
{
    var atom:QuadTreeAtom<TestItem>;
    var range:QuadTreeRange;
    var maxDataPerNode:Int;
    var threshold:Float;

    var node:QuadTreeNode<TestItem>;

    function setupExample()
    {
        range = new QuadTreeRange(new Position(0, 0), 10);
        maxDataPerNode = 2;
        threshold = 0.01;
        node = atom = new QuadTreeAtom<TestItem>(range, maxDataPerNode, threshold);
    }

    function addData(x:Float, y:Float, item:TestItem):QuadTreeData<TestItem>
    {
        var data = makeData(x, y, item);
        node = atom.add(data);
        return data;
    }

    function makeData(x:Float, y:Float, item:TestItem):QuadTreeData<TestItem>
        return new QuadTreeData<TestItem>(new Position(x, y), item)

    @Test public function firstItemIsAddedToAtom()
    {
        setupExample();
        var data = addData(3, 3, new TestItem());
        Assert.areEqual(atom.count, 1);
    }

    @Test public function afterMaxItemsAtomIsDivided()
    {
        setupExample();
        var a = addData(3, 3, new TestItem());
        var b = addData(4, 3, new TestItem());
        var c = addData(3, 4, new TestItem());
        Assert.areNotSame(atom, node);
    }

}

class TestItem
{
    public function new() {}
}