package dust.systems.ui;

import dust.stats.RollingMean;
import dust.systems.impl.SystemMetrics;
import dust.ui.components.Label;
import dust.ui.api.UIView;

import haxe.Timer;

using dust.FloatUtil;

class FrameRateView extends UIView
{
    var label:Label;
    var rollingMean:RollingMean;
    var elapsedTimeSinceUpdate:Float;
    var updatesThisSecond:Int;

    public function new()
    {
        super();
        label = new Label("??fps");
        display.addChild(label);
        rollingMean = new RollingMean(5);
        updatesThisSecond = 0;
        elapsedTimeSinceUpdate = 0;
    }

    override public function refresh(deltaTime:Float)
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
