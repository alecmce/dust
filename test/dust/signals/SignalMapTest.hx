package dust.signals;

import dust.lists.MockData;
import massive.munit.Assert;
import dust.signals.SignalVoid;
import dust.signals.Signal;
import minject.Injector;

class SignalMapTest
{
    var injector:Injector;
    var signalMap:SignalMap;
    var methodData:MockData;
    var secondMethodData:MockData;

    @Before public function before()
    {
        injector = new Injector();
        signalMap = new SignalMap(injector);
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

class MockData
{
    public function new() {}
}

class MockSignal extends Signal<MockData>
{

}