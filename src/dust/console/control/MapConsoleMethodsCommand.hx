package dust.console.control;

import dust.commands.CommandVoid;
import dust.console.ui.ConsoleOutput;
import dust.console.impl.ConsoleMap;

class MapConsoleMethodsCommand implements CommandVoid
{
    @inject public var consoleMap:ConsoleMap;
    @inject public var output:ConsoleOutput;

    public function execute()
    {
        consoleMap.map("list")
            .toMethod(onList)
            .describe("lists all the mapped console actions and their descriptions");
    }

    function onList(arguments:Array<String>)
    {
        for (mapping in consoleMap)
            output.write(mapping.getDescription());
    }
}
