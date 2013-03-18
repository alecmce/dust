package dust.lists;


class LinkedListTest
{
    var list:LinkedList<Data>;

    @Before public function before()
        list = new LinkedList<Data>(itemProvider)

        function itemProvider(data:Data):LinkedListItem<Data>
            return new LinkedListItem<Data>(data)

    function dataIsIteratedOver(data:Data):Bool
    {
        var isIteratedOver = false;
        for (item in list)
        {
            if (data == item)
                isIteratedOver = true;
        }
        return isIteratedOver;
    }

    @Test public function appendedDataIsIteratedOver()
    {
        var data = new Data();
        list.append(data);
        Assert.isTrue(dataIsIteratedOver(data));
    }

    @Test public function removedDataIsNotIteratedOver()
    {
        var data = new Data();
        list.append(data);
        list.remove(data);
        Assert.isFalse(dataIsIteratedOver(data));
    }

    @Test public function canMakeListItemAndAppendDirectly()
    {
        var data = new Data();
        var item = itemProvider(data);
        list.appendItem(item);
        Assert.isTrue(dataIsIteratedOver(data));
    }

    @Test public function canDetachItemFromListDirectly()
    {
        var data = new Data();
        var item = itemProvider(data);
        list.appendItem(item);
        list.detachNodeFromList(item);
        Assert.isFalse(dataIsIteratedOver(data));
    }
}

class Data
{
    public function new() {}
}
