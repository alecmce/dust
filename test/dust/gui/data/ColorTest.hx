package dust.gui.data;

class ColorTest
{
    var color:Color;

    @Before public function before()
    {
        color = new Color(0x996633, 1);
    }

    @Test public function redChannel()
    {
        Assert.areEqual(color.getRed(), 0x99 / 0xFF);
    }

    @Test public function greenChannel()
    {
        Assert.areEqual(color.getGreen(), 0x66 / 0xFF);
    }

    @Test public function blueChannel()
    {
        Assert.areEqual(color.getBlue(), 0x33 / 0xFF);
    }
}
