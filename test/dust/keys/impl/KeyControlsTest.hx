package dust.keys.impl;

import massive.munit.Assert;
import dust.lists.SimpleList;

class KeyControlsTest
{
    var controls:KeyControls;
    var isCalled:Bool;

    @Before public function before()
    {
        var list = new SimpleList<KeyControl>();
        controls = new KeyControls(list);
        isCalled = false;
    }

    @Test public function mappedMethodsAreCalled()
    {
        controls.map(1, testMethod);
        for (control in controls)
            control.call(0);
        Assert.isTrue(isCalled);
    }

    @Test public function unmappedMethodsAreNotCalled()
    {
        var control = controls.map(1, testMethod);
        controls.unmap(control);
        for (control in controls)
            control.call(0);
        Assert.isFalse(isCalled);
    }

        function testMethod(deltaTime:Float)
        {
            isCalled = true;
        }
}
