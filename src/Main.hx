package;

import nme.display.Sprite;
import dust.canvas.PrioritizedPaintersConfig;
import dust.context.Context;
import minject.Injector;
class Main
{
    public static function main()
    {
        new Main();
    }

    var injector:Injector;
    var context:Context;

    public function new()
    {
        context = new Context(injector = new Injector())
            .configure(PrioritizedPaintersConfig)
            .start(new Sprite());
    }
}
