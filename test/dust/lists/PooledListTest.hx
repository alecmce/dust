package dust.lists;

import dust.lists.PooledList;

class PooledListTest
{
    var list:PooledList<MockData>;

    @Before public function before()
    {
        list = new PooledList<MockData>();
        list.populate(10);
    }

    function makeAndAppend():MockData
    {
        var data = new MockData();
        list.append(data);
        return data;
    }

    function makeAndPrefix():MockData
    {
        var data = new MockData();
        list.prefix(data);
        return data;
    }

    function getListIndex(item:MockData):Int
    {
        var index = 0;
        for (listItem in list)
        {
            if (item == listItem)
                return index;
            else
                index++;
        }

        return -1;
    }

    public function listHasItem(item:MockData):Bool
    {
        return getListIndex(item) != -1;
    }

    @Test public function appendAddsItem()
    {
        var data = makeAndAppend();
        Assert.isTrue(listHasItem(data));
    }

    @Test public function appendAddsItemToEnd()
    {
        makeAndAppend();
        makeAndAppend();
        var data = makeAndAppend();
        Assert.areEqual(getListIndex(data), 2);
    }

    @Test public function prefixAddsItem()
    {
        var data = makeAndPrefix();
        Assert.isTrue(listHasItem(data));
    }

    @Test public function prefixAddsItemToStart()
    {
        makeAndAppend();
        makeAndAppend();
        var data = makeAndPrefix();
        Assert.areEqual(getListIndex(data), 0);
    }

    @Test public function removeRemovesItemFromList()
    {
        makeAndAppend();
        var data = makeAndAppend();
        makeAndAppend();
        list.remove(data);
        Assert.areEqual(getListIndex(data), -1);
    }

    @Test public function listRemainsJoinedWhenItemIsRemoved()
    {
        makeAndAppend();
        var middle = makeAndAppend();
        var tail = makeAndAppend();
        list.remove(middle);
        Assert.areEqual(getListIndex(tail), 1);
    }
}