package dust.systems.ui;

import flash.display.DisplayObject;
import flash.display.Sprite;
import dust.gui.data.UIView;
import dust.gui.control.UILabelFactory;
import dust.entities.api.Entity;
import flash.text.Font;
import dust.stats.RollingMean;
import dust.systems.impl.SystemMetrics;
import dust.gui.ui.UILabel;
import dust.gui.data.UIContainer;

import haxe.Timer;

using dust.FloatUtil;

class FrameRateView implements UIView
{
    public var display:DisplayObject;

    var factory:UILabelFactory;
    var label:UILabel;
    var rollingMean:RollingMean;
    var elapsedTimeSinceUpdate:Float;
    var updatesThisSecond:Int;

    public function new(factory:UILabelFactory)
    {
        this.factory = factory;
        display = label = factory.makeWithDefaults("??fps");
        rollingMean = new RollingMean(5);
        updatesThisSecond = 0;
        elapsedTimeSinceUpdate = 0;
    }

    public function refresh(entity:Entity, deltaTime:Float)
    {
        ++updatesThisSecond;
        elapsedTimeSinceUpdate += deltaTime;
        if (elapsedTimeSinceUpdate >= 1)
        {
            elapsedTimeSinceUpdate = 0;
            updateFrameRate();
        }
    }

        function updateFrameRate()
        {
            rollingMean.update(updatesThisSecond);
            updatesThisSecond = 0;
            label.setLabel(rollingMean.getMean().toFixed(0) + "fps");
        }
}
