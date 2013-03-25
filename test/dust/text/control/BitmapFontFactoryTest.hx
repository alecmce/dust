package dust.text.control;

import dust.text.data.BitmapFont;
import nme.geom.Rectangle;
import nme.display.BitmapData;
import dust.context.Context;

import nme.display.Sprite;
import minject.Injector;

class BitmapFontFactoryTest
{
    var factory:BitmapFontFactory;
    var font:BitmapFont;

    @Before public function before()
    {
        var injector = new Injector();
        var context = new Context(injector)
            .configure(BitmapTextConfig)
            .start(new Sprite());

        factory = injector.getInstance(BitmapFontFactory);
    }

    function makeFontDefinition()
    {
        var buffer = new Array<String>();
        buffer.push('info face="Michroma" size=24 bold=0 italic=0 charset="" unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0');
        buffer.push('common lineHeight=34 base=28 scaleW=256 scaleH=256 pages=1 packed=0');
        buffer.push('page id=0 file="michroma-24-black.png"');
        buffer.push('chars count=95');
        buffer.push('char id=32 x=0 y=0 width=0 height=0 xoffset=0 yoffset=28 xadvance=6 page=0 chnl=0');
        buffer.push('char id=33 x=2 y=0 width=2 height=50 xoffset=0 yoffset=10 xadvance=6 page=0 chnl=0');
        buffer.push('char id=34 x=4 y=0 width=2 height=50 xoffset=0 yoffset=8 xadvance=9 page=0 chnl=0');
        buffer.push('char id=35 x=6 y=0 width=2 height=50 xoffset=0 yoffset=9 xadvance=18 page=0 chnl=0');
        buffer.push('char id=36 x=8 y=0 width=2 height=50 xoffset=0 yoffset=7 xadvance=24 page=0 chnl=0');
        buffer.push('char id=37 x=10 y=0 width=2 height=50 xoffset=-1 yoffset=10 xadvance=12 page=0 chnl=0');
        buffer.push('char id=38 x=12 y=0 width=2 height=50 xoffset=0 yoffset=8 xadvance=29 page=0 chnl=0');
        buffer.push('char id=39 x=14 y=0 width=2 height=50 xoffset=0 yoffset=8 xadvance=6 page=0 chnl=0');
        buffer.push('char id=40 x=16 y=0 width=2 height=50 xoffset=0 yoffset=8 xadvance=9 page=0 chnl=0');
        buffer.push('char id=41 x=18 y=0 width=2 height=50 xoffset=0 yoffset=8 xadvance=9 page=0 chnl=0');
        return buffer.join('\n');
    }

    function makeFontData()
    {
        var data = new BitmapData(200, 50, true, 0);
        data.fillRect(new Rectangle(0, 0, 50, 50), 0xFFFF0000);
        data.fillRect(new Rectangle(50, 0, 50, 50), 0xFF00FF00);
        data.fillRect(new Rectangle(100, 0, 50, 50), 0xFF0000FF);
        data.fillRect(new Rectangle(150, 0, 50, 50), 0xFFFFFF00);
        return [data];
    }

    function makeFont()
    {
        font = factory.make(makeFontDefinition(), makeFontData());
    }

    @Test public function allCharsAreCreated()
    {
        makeFont();

        var list = [32, 33, 34, 35, 36, 37, 38, 39, 40, 41];
        for (id in list)
        {
            Assert.isNotNull(font.getChar(id));
        }
    }

    @Test public function undefinedCharsAreNotCreated()
    {
        makeFont();
        Assert.isNull(font.getChar(3));
    }
}
