package dust.commands;

import dust.commands.CommandMapConfig;
import dust.Injector;
import dust.context.Config;
import dust.commands.CommandMap;
import nme.display.Sprite;
import dust.context.Context;

class CommandMapConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        injector = new Injector();
        context = new Context(injector)
            .configure(CommandMapConfig)
            .start(new Sprite());
    }

    @Test public function commandMapIsInjected()
    {
        var commandMap:CommandMap = injector.getInstance(CommandMap);
        Assert.isNotNull(commandMap);
    }
}