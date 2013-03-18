package dust.console.impl;


class ConsoleLogTest
{
    var subject:ConsoleLog;

    @Before public function before()
    {
        subject = new ConsoleLog();
    }

    @Test public function canLogText()
    {
        subject.log("text");
    }

    @Test public function canRetrieveLastLoggedText()
    {
        subject.log("text");
        Assert.areEqual("text", subject.previous());
    }

    @Test public function canRetrieveOlderText()
    {
        subject.log("first");
        subject.log("second");
        subject.previous();
        Assert.areEqual("first", subject.previous());
    }

    @Test public function canMoveForwardsThroughTextToo()
    {
        subject.log("first");
        subject.log("second");
        subject.previous();
        subject.previous();
        Assert.areEqual("second", subject.next());
    }

    @Test public function ifNoPreviousReturnEmpty()
    {
        Assert.areEqual("", subject.previous());
    }

    @Test public function ifNoNextReturnEmpty()
    {
        Assert.areEqual("", subject.next());
    }
}
