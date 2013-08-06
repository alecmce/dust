package dust.signals;

import flash.display.Sprite;
import dust.context.Context;
import dust.Injector;

class PromiseMapTest
{
    var injector:Injector;
    var promiseMap:PromiseMap;
    var methodData:MockData;
    var secondMethodData:MockData;

    @Before public function before()
    {
        var context = new Context()
            .configure(SignalMapConfig)
            .start(new Sprite());

        injector = context.injector;
        promiseMap = injector.getInstance(PromiseMap);
    }

    @Test @TestDebug public function mappedPromiseTriggersMappedMethod()
    {
        promiseMap.map(MockPromise, method);
        var promise:MockPromise = injector.getInstance(MockPromise);

        var data = new MockData();
        promise.dispatch(data);
        Assert.areSame(data, methodData);
    }

        function method(data:MockData)
        {
            methodData = data;
        }

    @Test @TestDebug public function multipleMethodsCanBeMappedToTheSamePromise()
    {
        promiseMap.map(MockPromise, method);
        promiseMap.map(MockPromise, secondMethod);
        var promise:MockPromise = injector.getInstance(MockPromise);

        var data = new MockData();
        promise.dispatch(data);
        Assert.areSame(data, methodData);
        Assert.areSame(data, secondMethodData);
    }

        function secondMethod(data:MockData)
        {
            secondMethodData = data;
        }
}
