package dust.quadtree.data;

import dust.position.data.Position;
import dust.position.data.Position;
import dust.math.Random;

using Lambda;

class QuadTreeDivisionsTest
{
    var random:Random;
    var range:QuadTreeRange;
    var division:QuadTreeDivisions<QuadTreeDivisionTestItem>;

    @Before public function before()
    {
        random = new Random();
        range = new QuadTreeRange(new Position(0, 0), 100);
        division = new QuadTreeDivisions<QuadTreeDivisionTestItem>(range, 2, 0.01);
    }

        function addItem():QuadTreeDivisionTestItem
        {
            var item = new QuadTreeDivisionTestItem();
            var x = random.floatInRange(-100, 100);
            var y = random.floatInRange(-100, 100);
            var position = new Position(x, y);
            var data = new QuadTreeData<QuadTreeDivisionTestItem>(position, item);
            division.add(data);
            return item;
        }

    @Test public function canReferenceAddedItem()
    {
        var item = addItem();
        var list = new Array<QuadTreeDivisionTestItem>();
        division.populateDataInRange(range, list);
        Assert.areSame(item, list[0]);
    }

    @Test public function canReferenceAddedItems()
    {
        var items = new Array<QuadTreeDivisionTestItem>();
        for (i in 0...20)
            items.push(addItem());

        var list = new Array<QuadTreeDivisionTestItem>();
        division.populateDataInRange(range, list);

        for (item in items)
            Assert.isTrue(list.has(item));
    }
}

class QuadTreeDivisionTestItem
{
    public function new() {}
}