package dust.systems.ui;

import dust.ui.factory.UILabelFactory;
import dust.entities.api.Entity;
import nme.text.Font;
import dust.stats.RollingMean;
import dust.systems.impl.SystemMetrics;
import dust.ui.components.UILabel;
import dust.ui.data.UIView;

import haxe.Timer;

using dust.FloatUtil;

class FrameRateView extends UIView
{
    var factory:UILabelFactory;
    var label:UILabel;
    var rollingMean:RollingMean;
    var elapsedTimeSinceUpdate:Float;
    var updatesThisSecond:Int;

    public function new(factory:UILabelFactory)
    {
        super();
        this.factory = factory;
        label = factory.makeWithDefaults("??fps");
        display.addChild(label);
        rollingMean = new RollingMean(5);
        updatesThisSecond = 0;
        elapsedTimeSinceUpdate = 0;
    }

    override public function refresh(entity:Entity, deltaTime:Float)
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
