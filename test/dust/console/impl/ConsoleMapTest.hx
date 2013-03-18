package dust.console.impl;


class ConsoleMapTest
{
    var subject:ConsoleMap;
    var isCalled:Bool;

    @Before public function before()
    {
        subject = new ConsoleMap();
        isCalled = false;
    }

    @Test public function patternReturnsMapping()
    {
        Assert.isType(subject.map("test"), ConsoleMapping);
    }

    @Test public function samePatternReturnsSameMapping()
    {
        Assert.areSame(subject.map("test"), subject.map("test"));
    }

    @Test public function differentPatternsReturnsDifferentMappings()
    {
        Assert.areNotSame(subject.map("test"), subject.map("other"));
    }

    @Test public function executingAnUnmappedPatternDoesntFail()
    {
        subject.execute("undefined", [""]);
    }

    @Test public function executingMappedPatternFiresListeners()
    {
        subject.map("pattern").toMethod(method);
        subject.execute("pattern", ["data"]);
        Assert.isTrue(isCalled);
    }

        function method(_)
        {
            isCalled = true;
        }
}
