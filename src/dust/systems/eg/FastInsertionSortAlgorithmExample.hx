package dust.systems.eg;

import dust.entities.Entities;
import dust.entities.Entity;
import dust.console.ui.ConsoleOutput;
import dust.console.ConsoleConfig;
import dust.lists.LinkedListItem;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.lists.LinkedList;

class FastInsertionSortAlgorithmExample implements DependentConfig
{
    @inject public var consoleOutput:ConsoleOutput;
    @inject public var entities:Entities;

    public function dependencies():Array<Class<Config>>
        return [ConsoleConfig];

    public function configure()
    {
        var arrays = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]];
        for (array in arrays)
        {
            var list = new LinkedList<Entity>(makeItem);
            for (value in array)
                list.append(makeEntity(value));
            doSort(list, sorter);
            consoleOutput.write('entities: $array => ${toArray(list)}');
        }
    }

        function makeEntity(value:Int):Entity
        {
            var entity = entities.require();
            entity.add(new SortValue(value));
            return entity;
        }

        function makeItem(item:Entity):LinkedListItem<Entity>
            return new LinkedListItem<Entity>(item);

        function sorter(a:Entity, b:Entity):Int
            return a.get(SortValue).value - b.get(SortValue).value;

        function toArray(list:LinkedList<Entity>):Array<Int>
        {
            var array = new Array<Int>();
            for (entity in list)
                array.push(entity.get(SortValue).value);
            return array;
        }

    function doSort(list:LinkedList<Entity>, sorter:Entity->Entity->Int)
    {
        var head = list.head;
        var node = head.next;

        while (node != null)
        {
            var next = node.next;
            var prev = node.prev;
            var entity = node.data;

            if (sorter(entity, prev.data) < 0)
            {
                var candidate = prev;
                while (candidate.prev != null)
                {
                    if (sorter(entity, candidate.prev.data) < 0)
                        candidate = candidate.prev;
                    else
                        break;
                }

                if (next != null)
                {
                    prev.next = next;
                    next.prev = prev;
                }
                else
                {
                    prev.next = null;
                    list.tail = prev;
                }

                if (candidate == head)
                {
                    node.prev = null;
                    node.next = candidate;

                    candidate.prev = node;
                    head = node;
                }
                else
                {
                    node.prev = candidate.prev;
                    candidate.prev.next = node;

                    node.next = candidate;
                    candidate.prev = node;
                }
            }
            node = next;
        }

        list.head = head;
    }
}

class SortValue
{
    public var value:Int;

    public function new(value:Int)
        this.value = value;
}