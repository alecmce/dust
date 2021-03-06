package dust.signals;

import dust.context.Context;
import flash.display.Sprite;
import dust.Injector;

class SignalMapTest
{
    var injector:Injector;
    var signalMap:SignalMap;
    var methodData:MockData;
    var secondMethodData:MockData;

    @Before public function before()
    {
        var context = new Context()
            .configure(SignalMapConfig)
            .start(new Sprite());

        injector = context.injector;
        signalMap = injector.getInstance(SignalMap);
    }

    @Test public function mappedSignalTriggersMappedMethod()
    {
        signalMap.map(MockSignal, method);
        var signal:MockSignal = injector.getInstance(MockSignal);

        var data = new MockData();
        signal.dispatch(data);
        Assert.areSame(data, methodData);
    }

        function method(data:MockData)
        {
            methodData = data;
        }

    @Test public function multipleMethodsCanBeMappedToTheSameSignal()
    {
        signalMap.map(MockSignal, method);
        signalMap.map(MockSignal, secondMethod);
        var signal:MockSignal = injector.getInstance(MockSignal);

        var data = new MockData();
        signal.dispatch(data);
        Assert.areSame(data, methodData);
        Assert.areSame(data, secondMethodData);
    }

        function secondMethod(data:MockData)
        {
            secondMethodData = data;
        }
}
