package dust.systems;

import dust.gui.control.UILabelFactory;
import dust.systems.ui.FrameRateView;
import dust.context.UnconfigConfig;
import dust.systems.impl.Systems;
import dust.type.TypeIndex;
import dust.gui.data.UIView;
import dust.entities.api.Entity;
import dust.gui.data.Alignment;
import dust.geom.data.Position;
import dust.gui.data.VAlign;
import dust.gui.data.HAlign;
import dust.systems.ui.SystemMetricsView;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemMetrics;
import dust.entities.EntitiesConfig;
import dust.entities.api.Entities;
import dust.gui.GUIConfig;
import dust.context.DependentConfig;
import dust.context.Config;

import dust.Injector;
import nme.display.Stage;

class SystemMetricsConfig implements DependentConfig
{
    inline static var MEAN_DATA_POINTS = 25;
    inline static var OUTPUT_PRECISION = 4;

    @inject public var injector:Injector;
    @inject public var entities:Entities;
    @inject public var systems:Systems;
    @inject public var labelFactory:UILabelFactory;

    var metrics:SystemMetrics;
    var list:SystemsList;
    var metricsView:Entity;
    var frameRateView:Entity;

    public function dependencies():Array<Class<Config>>
    {
        return [EntitiesConfig, SystemsConfig, GUIConfig];
    }

    public function configure()
    {
        metrics = mapAndReferenceSystemMetrics();
        metricsView = makeSystemMetricsViewEntity();
        frameRateView = makeFrameRateViewEntity();
        systems.setMetrics(metrics);
    }

        function mapAndReferenceSystemMetrics():SystemMetrics
        {
            var metrics = new SystemMetrics(MEAN_DATA_POINTS);
            injector.mapValue(SystemMetrics, metrics);
            return injector.getInstance(SystemMetrics);
        }

        function makeSystemMetricsViewEntity()
        {
            var entity = entities.require();
            entity.addAsType(new SystemMetricsView(labelFactory, metrics, OUTPUT_PRECISION), UIView);
            entity.add(new Alignment(HAlign.LEFT, VAlign.BOTTOM));
            entity.add(new Position(0, stage().stageHeight));
            return entity;
        }

        function makeFrameRateViewEntity()
        {
            var entity = entities.require();
            entity.addAsType(new FrameRateView(labelFactory), UIView);
            entity.add(new Alignment(HAlign.RIGHT, VAlign.TOP));
            entity.add(new Position(stage().stageWidth, 0));
            return entity;
        }

            inline function stage():Stage
                return nme.Lib.current.stage
}