package dust.systems.systems;

import dust.systems.impl.Systems;
import dust.systems.impl.CollectionSort;
import dust.lists.LinkedListItem;
import dust.entities.api.Entities;
import nme.display.Sprite;
import dust.entities.EntitiesConfig;
import dust.context.Context;
import dust.components.Component;
import dust.entities.api.Entity;
import dust.lists.LinkedList;
import dust.systems.impl.CollectionSort;
import dust.systems.impl.CollectionSorts;

class SortCollectionsSystemTest
{
    var sorts:CollectionSorts;
    var systems:Systems;
    var entities:Entities;

    @Before public function before()
    {
        var context = new Context()
            .configure(SystemsConfig)
            .start(new Sprite());

        var injector = context.injector;
        sorts = injector.getInstance(CollectionSorts);
        systems = injector.getInstance(Systems);
        entities = injector.getInstance(Entities);
    }

    @Test public function sort123() sortAndAssertIsSorted([1, 2, 3])
    @Test public function sort132() sortAndAssertIsSorted([1, 3, 2])
    @Test public function sort213() sortAndAssertIsSorted([2, 1, 3])
    @Test public function sort231() sortAndAssertIsSorted([2, 3, 1])
    @Test public function sort312() sortAndAssertIsSorted([3, 1, 2])
    @Test public function sort321() sortAndAssertIsSorted([3, 2, 1])

        function sortAndAssertIsSorted(values:Array<Int>)
        {
            var sort = makeSort(values);
            sorts.add(sort);
            systems.update();
            Assert.arraysAreEqual([1, 2, 3], getResult(sort));
        }

            function makeSort(values:Array<Int>):CollectionSort
            {
                var list = new LinkedList<Entity>(makeItem);
                for (value in values)
                {
                    var entity = entities.require();
                    entity.add(new SortValue(value));
                    list.append(entity);
                }
                return new CollectionSort(list, sorter);
            }

                function makeItem(entity:Entity):LinkedListItem<Entity>
                    return new LinkedListItem<Entity>(entity)

                function sorter(a:Entity, b:Entity):Int
                    return a.get(SortValue).value - b.get(SortValue).value

            function getResult(sort:CollectionSort):Array<Int>
            {
                var list = new Array<Int>();
                for (entity in sort.list)
                    list.push(entity.get(SortValue).value);
                return list;
            }
}

class SortValue extends Component
{
    public var value:Int;

    public function new(value:Int)
        this.value = value
}