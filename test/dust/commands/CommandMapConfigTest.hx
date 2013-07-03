package dust.commands;

import dust.commands.CommandMapConfig;
import dust.Injector;
import dust.context.Config;
import dust.commands.CommandMap;
import flash.display.Sprite;
import dust.context.Context;

class CommandMapConfigTest
{
    var injector:Injector;
    var context:Context;

    @Before public function before()
    {
        context = new Context()
            .configure(CommandMapConfig)
            .start(new Sprite());
        injector = context.injector;
    }

    @Test public function commandMapIsInjected()
    {
        var commandMap:CommandMap = injector.getInstance(CommandMap);
        Assert.isNotNull(commandMap);
    }
}