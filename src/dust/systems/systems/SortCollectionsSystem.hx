package dust.systems.systems;

import dust.lists.LinkedList;
import dust.entities.Entity;
import dust.entities.EntityList;
import dust.systems.impl.CollectionSorts;

class SortCollectionsSystem implements System
{
    @inject public var sorts:CollectionSorts;

    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (sort in sorts)
        {
            var list = sort.list;
            var sorter = sort.sorter;
            if (list.head != null)
                doSort(list, sorter);
        }
    }

        inline function doSort(list:LinkedList<Entity>, sorter:Entity->Entity->Int)
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
