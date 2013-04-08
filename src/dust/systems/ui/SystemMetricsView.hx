package dust.systems.ui;

import dust.ui.factory.UILabelFactory;
import dust.entities.api.Entity;
import dust.systems.impl.SystemMetricsData;
import dust.stats.RollingMean;
import dust.systems.impl.SystemMetrics;
import dust.systems.impl.SystemsList;
import dust.type.TypeIndex;
import dust.ui.data.UIView;
import dust.ui.components.UILabel;
import dust.ui.components.VerticalList;

import nme.display.Stage;

using dust.FloatUtil;

class SystemMetricsView extends UIView
{
    var factory:UILabelFactory;
    var metrics:SystemMetrics;
    var precision:Int;
    var isEnabled:Bool;

    var timeSinceLastUpdate:Float;

    var ui:VerticalList;
    var hash:Hash<UILabel>;

    public function new(factory:UILabelFactory, metrics:SystemMetrics, precision:Int)
    {
        this.factory = factory;
        this.metrics = metrics;
        this.precision = precision;
        this.isEnabled = false;

        ui = makeVerticalList();
        ui.addItem(factory.makeWithDefaults("Systems"));
        hash = new Hash<UILabel>();

        timeSinceLastUpdate = 0;

        super();
        display.addChild(ui);
    }

        function makeVerticalList():VerticalList
        {
            var verticalList = new VerticalList([], 3);
            verticalList.mouseEnabled = false;
            verticalList.mouseChildren = false;
            return verticalList;
        }

        inline function getStage():Stage
            return nme.Lib.current.stage

    override public function refresh(entity:Entity, deltaTime:Float)
    {
        timeSinceLastUpdate += deltaTime;
        if (timeSinceLastUpdate >= 1)
        {
            timeSinceLastUpdate = 0;
            updateUI();
        }
    }

        function updateUI()
        {
            for (data in metrics)
                updateSystem(data);
        }

            function updateSystem(data:SystemMetricsData)
            {
                data.update();
                var text = data.label;
                var value = data.getMean().toFixed(precision);
                getLabel(text).setLabel(value + "ms " + text);
            }

                function getLabel(name:String):UILabel
                    return hash.exists(name) ? hash.get(name) : makeLabel(name)

                    function makeLabel(name:String)
                    {
                        var label = factory.makeWithDefaults(name);
                        hash.set(name, label);
                        ui.addItem(label);
                        return label;
                    }
}