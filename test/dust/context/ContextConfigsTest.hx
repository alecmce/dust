package dust.context;

import dust.context.DependentConfig;
import dust.context.UnconfigConfig;
import dust.Injector;

class ContextConfigsTest
{
    public static var CONFIG_ID:Int;
    public static var UNCONFIG_ID:Int;

    var injector:Injector;
    var configs:ContextConfigs;

    @Before public function before()
    {
        injector = new Injector();
        configs = new ContextConfigs(injector);
        CONFIG_ID = 0;
        UNCONFIG_ID = 0;
    }

    @Test public function configsConfiguredOnConfigure()
    {
        configs.add(ExampleConfig);
        configs.configure();
        Assert.areEqual(ConfigStatus.CONFIGURED, ExampleConfig.status);
    }

    @Test public function dependentsConfiguredOnConfigure()
    {
        configs.add(ExampleConfig);
        configs.configure();
        Assert.areEqual(ConfigStatus.CONFIGURED, ExampleDependentConfig.status);
    }

    @Test public function unconfigsUnconfiguredOnUnconfigure()
    {
        configs.add(ExampleConfig);
        configs.configure();
        configs.unconfigure();
        Assert.areEqual(ConfigStatus.UNCONFIGURED, ExampleConfig.status);
    }

    @Test public function dependentUnconfigsUnconfiguredOnUnconfigure()
    {
        configs.add(ExampleConfig);
        configs.configure();
        configs.unconfigure();
        Assert.areEqual(ConfigStatus.UNCONFIGURED, ExampleDependentConfig.status);
    }

    @Test public function dependentsAreConfiguredBeforeDependees()
    {
        configs.add(ExampleConfig);
        configs.configure();
        Assert.isTrue(ExampleDependentConfig.configIndex < ExampleConfig.configIndex);
    }

    @Test public function dependeesAreUnconfiguredBeforeDependents()
    {
        configs.add(ExampleConfig);
        configs.configure();
        configs.unconfigure();
        Assert.isTrue(ExampleDependentConfig.unconfigIndex > ExampleConfig.unconfigIndex);
    }
}

class ExampleConfig
    implements DependentConfig
    implements UnconfigConfig
{
    public static var status:ConfigStatus;
    public static var configIndex:Int;
    public static var unconfigIndex:Int;

    public function new()
        status = ConfigStatus.INSTANTIATED;

    public function dependencies():Array<Class<Config>>
        return [ExampleDependentConfig];

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

class ExampleDependentConfig
    implements UnconfigConfig
{
    public static var status:ConfigStatus;
    public static var configIndex:Int;
    public static var unconfigIndex:Int;

    public function new()
        status = ConfigStatus.INSTANTIATED;

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

enum ConfigStatus
{
    INSTANTIATED;
    CONFIGURED;
    UNCONFIGURED;
}