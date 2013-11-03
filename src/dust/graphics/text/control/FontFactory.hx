package dust.graphics.text.control;

import dust.graphics.text.data.FontDefinitionData;
import dust.graphics.data.Texture;
import dust.graphics.text.data.Font;

class FontFactory
{
    @inject public var charFactory:CharFactory;

    var chars:Array<FontDefinitionData>;
    var kerning:Array<FontDefinitionData>;
    var font:Font;
    var padding:Float;

    public function make(definition:String, source:Texture, padding:Float):Font
    {
        chars = new Array<FontDefinitionData>();
        kerning = new Array<FontDefinitionData>();
        font = new Font();
        this.padding = padding;

        parseDefinition(definition);
        applyChars(source);
        applyKerning();

        chars = null;
        kerning = null;
        return font;
    }

    function parseDefinition(definition:String)
    {
        var lines = definition.split('\n');
        for (line in lines)
        {
            var data = makeData(line);
            switch (data.name)
            {
                case 'info':
                    applyInfo(data);
                case 'common':
                    applyCommon(data);
                case 'char':
                    chars.push(data);
                case 'kerning':
                    kerning.push(data);
            }
        }
    }
        function makeData(line:String):FontDefinitionData
        {
            var pairs = line.split(" ");
            var item = new FontDefinitionData(pairs.shift());

            for (pair in pairs)
            {
                var keyvalue = pair.split("=");
                if (keyvalue.length > 1)
                {
                    var key = keyvalue[0];
                    var value = keyvalue[1].split('"').join('');
                    item.define(key, value);
                }
            }

            return item;
        }

        function applyInfo(data:FontDefinitionData)
        {
            font.name = data.getString('face');
            font.size = data.getInt('size');
            font.bold = data.getBool('bold');
            font.italic = data.getBool('italic');
        }

        function applyCommon(data:FontDefinitionData)
        {
            font.lineHeight = data.getInt('lineHeight');
            font.base = data.getInt('base');
        }

    function applyChars(source:Texture)
    {
        for (map in chars)
            addChar(map, source);
    }

        function addChar(data:FontDefinitionData, source:Texture)
        {
            var id = String.fromCharCode(data.getInt('id'));
            var key = '${font.name}-$id';
            var char = charFactory.make(key, data, source, padding);
            font.addChar(char);
        }

    function applyKerning()
    {
        for (map in kerning)
            addKerning(map);
    }

        function addKerning(data:FontDefinitionData)
        {
            var first = data.getInt('first');
            var char = font.getChar(first);
            if (char != null)
            {
                var second = data.getInt('second');
                var amount = data.getInt('amount');
                char.addKerning(second, amount);
            }
        }

}
