package dust.commands;

import dust.signals.MockData;

class MockCommand implements Command<MockData>
{
    public static var data:MockData;

    public function execute(data:MockData)
    {
        MockCommand.data = data;
    }
}