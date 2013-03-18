package dust.quadtree.data;

import dust.position.data.Position;
import dust.math.Random;
import dust.context.Context;
import dust.collections.api.Collection;
import dust.entities.api.Entities;
import dust.entities.api.Entity;
import dust.entities.EntitiesConfig;
import dust.collections.control.CollectionMap;
import dust.position.data.Position;

import minject.Injector;
import nme.display.Sprite;

class QuadTreeTest
{
    var random:Random;

    var range:QuadTreeRange;
    var tree:QuadTree<QuadTreeTestItem>;

    @Before public function before()
    {
        random = new Random();
    }

    public function makeTree(maxPerQuad:Int)
    {
        range = new QuadTreeRange(new Position(0, 0), 100);
        tree = new QuadTree<QuadTreeTestItem>(range, maxPerQuad, 0.01);
    }

        function addItem(x:Float, y:Float):QuadTreeTestItem
        {
            var item = new QuadTreeTestItem();
            tree.add(new Position(x, y), item);
            return item;
        }

    @Test public function afterUpdateCanGet()
    {
        makeTree(3);
        var item = addItem(10, 10);
        var range = new QuadTreeRange(new Position(0, 0), 20);
        Assert.areSame(tree.getData(range)[0], item);
    }

    @Test public function whenFirstQuadIsHasMaxElementsItSubdivides()
    {
        makeTree(1);
        addItem(10, 10);
        addItem(-10, -10);
        Assert.isTrue(tree.getRanges(tree.range).length > 1);
    }

    @Test public function canAddHundredsOfElements()
    {
        makeTree(1);
        for (i in 0...100)
        {
            var x = random.floatInRange(-100, 100);
            var y = random.floatInRange(-100, 100);
            addItem(x, y);

        }
        Assert.isTrue(tree.getRanges(tree.range).length > 5);
    }

    @Test public function addingItemOutsideRangeThrowsError()
    {
        makeTree(1);

        var isError = false;
        try
        {
            addItem(200, 200);
        }
        catch (error:OutOfBoundsError)
        {
            isError = true;
        }

        Assert.isTrue(isError);
    }
}

class QuadTreeTestItem
{
    public function new() {}
}
