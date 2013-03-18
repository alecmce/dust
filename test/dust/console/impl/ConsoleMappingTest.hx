package dust.console.impl;


class ConsoleMappingTest
{
    var subject:ConsoleMapping;

    var first:Array<String>;
    var second:Array<String>;

    @Before public function before()
    {
        subject = new ConsoleMapping("name");
    }

    @Test public function addedMethodIsCalledOnExecute()
    {
        subject.toMethod(firstMethod);
        subject.execute(["a"]);
        Assert.isNotNull(first);
    }

    @Test public function multipleMethodsAreCalledOnExecute()
    {
        subject.toMethod(firstMethod);
        subject.toMethod(secondMethod);
        subject.execute(["a"]);
        Assert.isNotNull(first);
        Assert.isNotNull(second);
    }

    function firstMethod(data:Array<String>)
    {
        first = data;
    }

    function secondMethod(data:Array<String>)
    {
        second = data;
    }
}
