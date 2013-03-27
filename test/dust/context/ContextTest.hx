package dust.context;

import dust.context.DependentConfig;
import dust.context.Context;
import dust.context.Config;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import dust.Injector;


class ContextTest
{
    var root:Sprite;
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        root = new Sprite();
        context = new Context();
        injector = context.injector;
    }

    @After
    public function after()
    {
        if (root.parent != null)
            root.parent.removeChild(root);
    }

    @Test public function canConfigureInjectionsByPassingAConfigClass()
    {
        context.configure(MockConfig);
        context.start(new Sprite());
        Assert.areEqual(injector.getInstance(String), "hello");
    }

    @Test public function theDependenciesOfADependentConfigAreConfigured()
    {
        context.configure(MockDependentConfig);
        context.start(new Sprite());
        Assert.areEqual(injector.getInstance(String), "hello");
    }

    @Test public function canPassSameConfigurationTwice()
    {
        context.configure(MockConfig);
        context.configure(MockConfig);
        context.start(new Sprite());
    }

    @Test public function theContextIsInjected()
    {
        var injected = injector.getInstance(Context);
        Assert.isNotNull(injected);
    }

    @Test public function startAddsRootToStage()
    {
        context.start(root);
        Assert.isNotNull(root.parent);
    }

    @Test public function stopRemovesRootFromStage()
    {
        context.start(root);
        context.stop();
        Assert.isNull(root.parent);
    }
}

class MockConfig implements Config
{
    @inject
    public var injector:Injector;

    public function configure()
    {
        injector.mapValue(String, "hello");
    }
}

class MockDependentConfig implements DependentConfig
{
    public function dependencies():Array<Class<Config>>
    {
        return [MockConfig];
    }

    public function configure() {}
}