package dust.commands;

import massive.munit.Assert;
import minject.Injector;
import dust.signals.SignalMap;
import dust.signals.SignalVoid;
import dust.signals.Signal;
import minject.Injector;

class CommandMapTest
{
    var injector:Injector;
    var commandMap:CommandMap;

    @Before public function before()
    {
        injector = new Injector();
        commandMap = new CommandMap(injector, new SignalMap(injector));
    }

    @Test public function mappedSignalTriggersMappedCommand()
    {
        commandMap.map(MockSignal, MockCommand);
        var signal:MockSignal = injector.getInstance(MockSignal);

        var data:MockData = new MockData();
        signal.dispatch(data);
        Assert.areSame(data, MockCommand.data);
    }
}

class MockData
{
    public function new() {}
}

class MockSignal extends Signal<MockData>
{

}

class MockCommand implements Command<MockData>
{
    public static var data:MockData;

    public function execute(data:MockData)
    {
        MockCommand.data = data;
    }
}