package dust.gui.data;

class HSVColor
{
    var color:Color;

    var pR:Float;
    var pG:Float;
    var pB:Float;
    var value:Float;
    var pMin:Float;
    var delta:Float;

    var hue:Float;
    var saturation:Float;
    var value:Float;

    public function new(color:Color)
    {
        this.color = color;
        update();
    }

    public function update()
    {
        pR = color.getRed() / 0xFF;
        pG = color.getGreen() / 0xFF;
        pB = color.getBlue() / 0xFF;

        value = pR > pG ? pR : pG;
        value = value > pB ? value : pB;

        pMin = pR < pG ? pR : pG;
        pMin = pMin < pB ? pMin : pB;

        delta = value - pMin;

        hue = calculateHue();
        saturation = delta / value;
    }

        inline function calculateHue()
        {
            return if (value == pR)
                ((pG - pB) / delta) % 6;
            else if (value == pG)
                ((pB - pR) / delta) + 2;
            else
                ((pR - pG) / delta) + 4;
        }

    inline public function getHue():Float
        return hue

    inline public function getSaturation():Float
        return saturation

    inline public function getValue():Float
        return value

    public function setHue(hue:Value):HSVColor
    {
        this.hue = hue;
        updateColor();
        return this;
    }

    public function setSaturation(saturation:Value):HSVColor
    {
        this.saturation = saturation;
        updateColor();
        return this;
    }

    public function setValue(value:Value):HSVColor
    {
        this.value = value;
        updateColor();
        return this;
    }

        inline function updateColor()
        {
            if (saturation == 0)
            {
                color.setRed(value);
                color.setGreen(value);
                color.setBlue(value);
            }
            else
            {
                var n = hue / 60;
                var floor_n = Std.int(n);
                var i = floor_n % 6;

                var f = n - floor_n;
                var p = value * (1 - saturation);
                var q = value * (1 - f * saturation);
                var t = value * (1 - (1 - f) * saturation);

                var rgb = switch (i)
                {
                    case 0: [value, t, p];
                    case 1: [q, value, p];
                    case 2: [p, value, t];
                    case 3: [p, q, value];
                    case 4: [t, p, value];
                    case 5: [value, p, q];
                }

                color.setRed(Std.int(rgb[0] * 0xFF));
                color.setGreen(Std.int(rgb[1] * 0xFF));
                color.setBlue(Std.int(rgb[2] * 0xFF));
            }
        }
}
