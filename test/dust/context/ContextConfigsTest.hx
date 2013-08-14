package dust.context;

import flash.display.Sprite;
import dust.signals.PromiseVoid;
import dust.context.DependentConfig;
import dust.context.UnconfigConfig;
import dust.Injector;

class ContextConfigsTest
{
    public static var CONFIG_ID:Int;
    public static var UNCONFIG_ID:Int;

    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        context = new Context();
        injector = context.injector;
        CONFIG_ID = 0;
        UNCONFIG_ID = 0;
    }

    @Test public function configsConfiguredOnConfigure()
    {
        context
            .configure(ExampleDependentConfig)
            .start(new Sprite());

        Assert.areEqual(ConfigStatus.CONFIGURED, ExampleDependentConfig.status);
    }

    @Test public function dependentsConfiguredOnConfigure()
    {
        context
            .configure(ExampleDependentConfig)
            .start(new Sprite());

        Assert.areEqual(ConfigStatus.CONFIGURED, ExampleUnconfigConfig.status);
    }

    @Test public function unconfigsUnconfiguredOnUnconfigure()
    {
        context
            .configure(ExampleDependentConfig)
            .start(new Sprite())
            .stop();

        Assert.areEqual(ConfigStatus.UNCONFIGURED, ExampleDependentConfig.status);
    }

    @Test public function dependentUnconfigsUnconfiguredOnUnconfigure()
    {
        context
            .configure(ExampleDependentConfig)
            .start(new Sprite())
            .stop();

        Assert.areEqual(ConfigStatus.UNCONFIGURED, ExampleUnconfigConfig.status);
    }

    @Test public function dependentsAreConfiguredBeforeDependees()
    {
        context
            .configure(ExampleDependentConfig)
            .start(new Sprite());

        Assert.isTrue(ExampleUnconfigConfig.configIndex < ExampleDependentConfig.configIndex);
    }

    @Test public function dependeesAreUnconfiguredBeforeDependents()
    {
        context
            .configure(ExampleDependentConfig)
            .start(new Sprite())
            .stop();

        Assert.isTrue(ExampleUnconfigConfig.unconfigIndex > ExampleDependentConfig.unconfigIndex);
    }

    @Test public function asyncConfigsDelayConfiguration()
    {
        context
            .configure(ExampleAsyncDependencyConfig)
            .start(new Sprite());

        Assert.areNotEqual(ConfigStatus.CONFIGURED, ExampleAsyncDependencyConfig.status);
    }

    @Test public function ifADependencyIsConfiguredExplicitlyBeforeItsDependeeItIsStillConfiguredAfterwards()
    {
        context
            .configure(ExampleUnconfigConfig)
            .configure(ExampleDependentConfig)
            .start(new Sprite());

        Assert.isTrue(ExampleUnconfigConfig.configIndex < ExampleDependentConfig.configIndex);
    }
}

class ExampleDependentConfig implements DependentConfig implements UnconfigConfig
{
    public static var status:ConfigStatus;
    public static var configIndex:Int;
    public static var unconfigIndex:Int;

    public function new()
    {
        status = ConfigStatus.INSTANTIATED;
    }

    public function dependencies():Array<Class<Config>>
    {
        return [ExampleUnconfigConfig];
    }

    public function configure()
    {
        status = ConfigStatus.CONFIGURED;
        configIndex = ++ContextConfigsTest.CONFIG_ID;
    }

    public function unconfigure()
    {
        status = ConfigStatus.UNCONFIGURED;
        unconfigIndex = ++ ContextConfigsTest.UNCONFIG_ID;
    }
}

class ExampleUnconfigConfig implements UnconfigConfig
{
    public static var status:ConfigStatus;
    public static var configIndex:Int;
    public static var unconfigIndex:Int;

    public function new()
    {
        status = ConfigStatus.INSTANTIATED;
    }

    public function configure()
    {
        status = ConfigStatus.CONFIGURED;
        configIndex = ++ContextConfigsTest.CONFIG_ID;
    }

    public function unconfigure()
    {
        status = ConfigStatus.UNCONFIGURED;
        unconfigIndex = ++ContextConfigsTest.UNCONFIG_ID;
    }
}

class ExampleAsyncDependencyConfig implements DependentConfig
{
    public static var status:ConfigStatus;

    public function new()
    {
        status = ConfigStatus.INSTANTIATED;
    }

    public function dependencies():Array<Class<Config>>
    {
        return [ExampleAsyncConfig];
    }

    public function configure()
    {
        status = ConfigStatus.CONFIGURED;
    }
}

class ExampleAsyncConfig implements AsyncConfig
{
    public var ready:PromiseVoid;

    public function new()
    {
        ready = new PromiseVoid();
    }

    public function configure()
    {
        haxe.Timer.delay(onConfigured, 100);
    }

    public function onConfigured()
    {
        ready.dispatch();
    }
}

enum ConfigStatus
{
    INSTANTIATED;
    CONFIGURED;
    UNCONFIGURED;
}