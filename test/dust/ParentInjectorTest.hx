package dust;

class ParentInjectorTest
{
    var parent:Injector;
    var child:Injector;

    @Before public function before()
    {
        parent = new Injector();
        child = new Injector(parent);
    }

    @Test public function canInjectSingleton()
    {
        parent.mapSingleton(ParentExampleClass);
        Assert.isTrue(child.hasMapping(ParentExampleClass));
    }

    @Test public function canInstantiateSingleton()
    {
        parent.mapSingleton(ParentExampleClass);
        Assert.isType(child.getInstance(ParentExampleClass), ParentExampleClass);
    }

    @Test public function injectorAlwaysReturnsSameInstanceForSingleton()
    {
        parent.mapSingleton(ParentExampleClass);
        var first = child.getInstance(ParentExampleClass);
        var second = child.getInstance(ParentExampleClass);
        Assert.areSame(first, second);
    }

    @Test public function canInjectValue()
    {
        var example = new ParentExampleClass();
        parent.mapValue(ParentExampleClass, example);
        Assert.isTrue(child.hasMapping(ParentExampleClass));
    }

    @Test public function childInjectionOverridesParentValueInjection()
    {
        var parentExample = new ParentExampleClass();
        var childExample = new ParentExampleClass();

        parent.mapValue(ParentExampleClass, parentExample);
        child.mapValue(ParentExampleClass, childExample);

        Assert.areSame(childExample, child.getInstance(ParentExampleClass));
    }

    @Test public function childInjectionOverridesParentSingletonInjection()
    {
        parent.mapSingleton(ParentExampleClass);
        child.mapSingleton(ParentExampleClass);

        var parentExample = parent.getInstance(ParentExampleClass);
        var childExample = child.getInstance(ParentExampleClass);

        Assert.areNotSame(childExample, parentExample);
    }
}

class ParentExampleClass
{
    public function new() {}
}

class ParentExampleClassWithDependencies
{
    @inject public var example:ParentExampleClass;

    public function new() {}
}
