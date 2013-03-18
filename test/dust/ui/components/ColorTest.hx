package dust.ui.components;

import dust.ui.components.Color;

class ColorTest
{
    var color:Color;

    @Before public function before()
    {
        color = new Color(0x996633, 1);
    }

    @Test public function redChannel()
    {
        Assert.areEqual(color.getRed(), 0x99);
    }

    @Test public function greenChannel()
    {
        Assert.areEqual(color.getGreen(), 0x66);
    }

    @Test public function blueChannel()
    {
        Assert.areEqual(color.getBlue(), 0x33);
    }
}
