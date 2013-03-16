package dust.lists;

import dust.lists.LinkedList;
import dust.lists.SortedList;
import massive.munit.Assert;

class SortedListTest
{
    var list:SortedList<MockData>;

    @Before public function before()
    {
        list = makeList();
    }

        function makeList():SortedList<MockData>
        {
            var simple = new SimpleList<MockData>();
            var sorter = sortMethod;
            return new SortedList<MockData>(simple, sorter);
        }

        function sortMethod(a:MockData, b:MockData):Int
        {
            return a.id - b.id;
        }

    function makeAndAddItem(id:Int):MockData
    {
        var item = new MockData(id);
        list.add(item);
        return item;
    }

    function toArray():Array<Int>
    {
        var array = new Array<Int>();
        for (item in list)
            array.push(item.id);

        return array;
    }

    @Test public function itemsAddedToListAreIteratedOverInOrder()
    {
        makeAndAddItem(1);
        makeAndAddItem(2);
        Assert.areEqual(toArray().join(","), "1,2");
    }

    @Test public function orderOfAdditionDoesNotMatter()
    {
        makeAndAddItem(2);
        makeAndAddItem(1);
        Assert.areEqual(toArray().join(","), "1,2");
    }
}