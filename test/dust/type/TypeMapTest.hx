package dust.type;

import flash.geom.Point;
import flash.display.Sprite;


class MacroExampleA { public function new() {} }
class MacroExampleB { public function new() {} }
typedef MyList = List<String>;
typedef ArrayString = Array<String>;
typedef ArrayInt = Array<Int>;
typedef ArrayFloat = Array<Float>;
typedef TypedPoint = Point;

class TypeMapTest
{
    private var map:TypeMap;

    @Before public function setUp()
    {
        map = new TypeMap();
    }

    @Test public function canAddAndRetrieveMember()
    {
        var example = new MacroExampleA();
        map.add(example);
        Assert.areSame(example, map.get(MacroExampleA));
    }

    @Test public function secondInstanceOfSameTypeOverwrites()
    {
        var example = new MacroExampleA();
        map.add(example);
        map.add(new MacroExampleA());
        Assert.areNotSame(example, map.get(MacroExampleA));
    }

    @Test public function byDefaultGetReturnsFalse()
    {
        Assert.isFalse(map.exists(MacroExampleA));
    }

    @Test public function onceAddedTypeExists()
    {
        map.add(new MacroExampleA());
        Assert.isTrue(map.exists(MacroExampleA));
    }

    @Test public function differentTypesAreSeparatelyAdded()
    {
        var a = new MacroExampleA();
        var b = new MacroExampleB();

        map.add(a);
        map.add(b);

        Assert.areSame(a, map.get(MacroExampleA));
        Assert.areSame(b, map.get(MacroExampleB));
    }

    @Test public function canMapString()
    {
        map.add("hello");
        Assert.areEqual("hello", map.get(String));
    }

    @Test public function canMapBool()
    {
        map.add(true);
        Assert.areEqual(true, map.get(Bool));
    }

    @Test public function typedefsAreFollowed()
    {
        var typePoint = new TypedPoint();
        map.add(typePoint);
        map.add(new Point());
        Assert.areNotSame(typePoint, map.get(TypedPoint));
    }
}