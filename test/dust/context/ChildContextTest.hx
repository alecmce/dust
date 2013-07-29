package dust.context;

import flash.display.Sprite;

class ChildContextTest
{
    var parentInjector:Injector;
    var parentContext:Context;
    var parentRoot:Sprite;

    var childInjector:Injector;
    var childContext:Context;
    var childRoot:Sprite;

    function makeParent()
    {
        parentContext = new Context()
            .configure(ChildContextExampleConfig)
            .start(parentRoot = new Sprite());
        parentInjector = parentContext.injector;
    }

    function makeChild()
    {
        childContext = new Context(parentContext)
            .configure(ChildContextExampleConfig)
            .start(childRoot = new Sprite());
        childInjector = childContext.injector;
    }

    @Before public function before()
    {
        ChildContextExampleConfig.COUNT = 0;
        makeParent();
        makeChild();
    }

    @Test public function configurationOnChildIsDuplicatedInParent()
    {
        Assert.areEqual(2, ChildContextExampleConfig.COUNT);
    }

    @Test public function bothRootsAreOnStage()
    {
        Assert.isNotNull(parentRoot.stage);
        Assert.isNotNull(childRoot.stage);
    }

    @Test public function childAndParentRootsHaveSameParent()
    {
        Assert.areSame(parentRoot.parent, childRoot.parent);
    }

    @Test public function childRootIsBelowParentRoot()
    {
        var parent = parentRoot.parent;
        Assert.isTrue(parent.getChildIndex(childRoot) < parent.getChildIndex(parentRoot));
    }
}

class ChildContextExampleConfig implements Config
{
    public static var COUNT = 0;

    @inject public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(ExampleInjectee);
        ++COUNT;
    }
}

class ExampleInjectee
{
    public function new() {}
}