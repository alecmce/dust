package dust.text.control;

import dust.text.data.BitmapFont;
import nme.geom.Rectangle;
import nme.display.BitmapData;
import dust.context.Context;

import nme.display.Sprite;
import dust.Injector;

class BitmapTextFactoryTest
{
    var fontFactory:BitmapFontFactory;
    var textFactory:BitmapTextFactory;

    @Before public function before()
    {
        var context = new Context()
            .configure(BitmapTextConfig)
            .start(new Sprite());

        fontFactory = context.injector.getInstance(BitmapFontFactory);
        textFactory = context.injector.getInstance(BitmapTextFactory);
    }

    @Before public function makesTextfieldProperly()
    {
        var text = textFactory.make(makeFont(), makeString([32, 33, 33]));
        Assert.areEqual(25, text.width);
        Assert.areEqual(10, text.height);
    }

    @Before public function rendersTextfieldProperly()
    {
        var text = textFactory.make(makeFont(), makeString([32, 33, 33]));
        Assert.areEqual(0xFFFF0000, text.getPixel(1, 1));
        Assert.areEqual(0xFF00FF00, text.getPixel(11, 1));
        Assert.areEqual(0xFF00FF00, text.getPixel(21, 1));
    }

        function makeString(codes:Array<Int>):String
        {
            var str = '';
            for (code in codes)
                str += String.fromCharCode(code);
            return str;
        }

        function makeFont():BitmapFont
            return fontFactory.make(makeFontDefinition(), makeFontData())

            function makeFontDefinition()
            {
                var buffer = new Array<String>();
                buffer.push('info face="tmp" size=10 bold=0 italic=0 charset="" unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=0,0');
                buffer.push('common lineHeight=12');
                buffer.push('char id=32 x=0 y=0 width=5 height=10 xoffset=0 yoffset=0 xadvance=5 page=0');
                buffer.push('char id=33 x=5 y=0 width=10 height=10 xoffset=0 yoffset=0 xadvance=10 page=0');
                return buffer.join('\n');
            }

            function makeFontData()
            {
                var data = new BitmapData(200, 50, true, 0);
                data.fillRect(new Rectangle(0, 0, 50, 50), 0xFFFF0000);
                data.fillRect(new Rectangle(50, 0, 50, 50), 0xFF00FF00);
                return [data];
            }
}
