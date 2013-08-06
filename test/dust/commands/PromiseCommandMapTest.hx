package dust.commands;

import dust.signals.MockData;
import dust.signals.MockPromise;
import dust.commands.PromiseCommandMap;
import dust.Injector;
import dust.signals.PromiseMap;
import dust.Injector;

class PromiseCommandMapTest
{
    var injector:Injector;
    var commandMap:PromiseCommandMap;

    @Before public function before()
    {
        injector = new Injector();
        commandMap = new PromiseCommandMap(injector, new PromiseMap(injector));
    }

    @Test public function mappedPromiseTriggersMappedCommand()
    {
        commandMap.map(MockPromise, MockCommand);
        var signal:MockPromise = injector.getInstance(MockPromise);

        var data:MockData = new MockData();
        signal.dispatch(data);
        Assert.areSame(data, MockCommand.data);
    }
}
