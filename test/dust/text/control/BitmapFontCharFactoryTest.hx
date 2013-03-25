package dust.text.control;

import dust.text.data.BitmapFontChar;
import nme.geom.Rectangle;
import nme.display.BitmapData;
import dust.context.Context;

import nme.display.Sprite;
import minject.Injector;

class BitmapFontCharFactoryTest
{
    var factory:BitmapFontCharFactory;
    var char:BitmapFontChar;

    @Before public function before()
    {
        var injector = new Injector();
        var context = new Context(injector)
            .configure(BitmapTextConfig)
            .start(new Sprite());

        factory = injector.getInstance(BitmapFontCharFactory);
    }

    function makeSourceData()
    {
        var data = new BitmapData(200, 50, true, 0);
        data.fillRect(new Rectangle(0, 0, 50, 50), 0xFFFF0000);
        data.fillRect(new Rectangle(50, 0, 50, 50), 0xFF00FF00);
        data.fillRect(new Rectangle(100, 0, 50, 50), 0xFF0000FF);
        data.fillRect(new Rectangle(150, 0, 50, 50), 0xFFFFFF00);
        return [data];
    }

    function makeSourceDefinition()
    {
        var data = new Hash<Dynamic>();
        data.set('id', 1);
        data.set('x', 50);
        data.set('y', 0);
        data.set('width', 30);
        data.set('height', 40);
        data.set('xoffset', 4);
        data.set('yoffset', 6);
        data.set('xadvance', 10);
        data.set('page', 0);
        return data;
    }

    function makeChar()
    {
        char = factory.make(makeSourceDefinition(), makeSourceData());
    }

    @Test public function parsesID()
    {
        makeChar();
        Assert.areEqual(1, char.id);
    }

    @Test public function parsesXOffset()
    {
        makeChar();
        Assert.areEqual(4, char.dx);
    }

    @Test public function parsesYOffset()
    {
        makeChar();
        Assert.areEqual(6, char.dy);
    }

    @Test public function parsesXAdvance()
    {
        makeChar();
        Assert.areEqual(10, char.advance);
    }
}
