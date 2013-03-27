package dust.context;

import nme.display.Sprite;

class ChildContextTest
{
    var parentInjector:Injector;
    var parentContext:Context;

    var childInjector:Injector;
    var childContext:Context;

    function makeParent()
    {
        parentInjector = new Injector();
        parentContext = new Context(parentInjector)
            .configure(ChildContextExampleConfig)
            .start(new Sprite());
    }

    function makeChild()
    {
        childInjector = new Injector(parentInjector);
        childContext = new Context(childInjector)
            .configure(ChildContextExampleConfig)
            .start(new Sprite());
    }

    @Test public function canInjectIntoBothContextsWithoutConflict()
    {
        makeParent();
        makeChild();
    }


}

class ChildContextExampleConfig implements Config
{
    @inject public var injector:Injector;

    public function configure()
    {
        injector.mapSingleton(ExampleInjectee);
    }
}

class ExampleInjectee
{
    public function new() {}
}