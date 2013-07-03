package dust.console.ui;

import flash.text.TextFormat;

class ConsoleFormat extends TextFormat
{
    public function new()
    {
        super();
        font = "monospaced";
        size = 12;
        color = 0xFFFFFF;
    }
}
