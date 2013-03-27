package dust;

class InjectorTest
{
    var injector:Injector;

    @Before public function before()
    {
        injector = new Injector();
    }

    @Test public function canInjectSingleton()
    {
        injector.mapSingleton(ExampleClass);
        Assert.isTrue(injector.hasMapping(ExampleClass));
    }

    @Test public function canInstantiateSingleton()
    {
        injector.mapSingleton(ExampleClass);
        Assert.isType(injector.getInstance(ExampleClass), ExampleClass);
    }

    @Test public function injectorAlwaysReturnsSameInstanceForSingleton()
    {
        injector.mapSingleton(ExampleClass);
        var first = injector.getInstance(ExampleClass);
        var second = injector.getInstance(ExampleClass);
        Assert.areSame(first, second);
    }

    @Test public function canInjectValue()
    {
        var example = new ExampleClass();
        injector.mapValue(ExampleClass, example);
        Assert.isTrue(injector.hasMapping(ExampleClass));
    }

    @Test public function canReferenceInjectedValue()
    {
        var example = new ExampleClass();
        injector.mapValue(ExampleClass, example);
        Assert.areSame(example, injector.getInstance(ExampleClass));
    }

    @Test public function instantiatedClassHasDependencies()
    {
        injector.mapSingleton(ExampleClass);
        injector.mapSingleton(ExampleClassWithDependencies);

        var instance = injector.getInstance(ExampleClassWithDependencies);
        Assert.isNotNull(instance.example);
    }

    @Test public function canResetInjections()
    {
        injector.mapSingleton(ExampleClass);
        injector.reset();
        Assert.isFalse(injector.hasMapping(ExampleClass));
    }
}

class ExampleClass
{
    public function new() {}
}

class ExampleClassWithDependencies
{
    @inject public var example:ExampleClass;

    public function new() {}
}
