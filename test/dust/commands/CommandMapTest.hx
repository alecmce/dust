package dust.commands;

import dust.signals.MockSignal;
import dust.signals.MockData;
import dust.Injector;
import dust.signals.SignalMap;
import dust.Injector;

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