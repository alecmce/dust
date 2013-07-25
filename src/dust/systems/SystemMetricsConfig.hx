package dust.systems;

import dust.gui.data.UIContainer;
import dust.gui.data.UIContainer;
import dust.app.data.App;
import dust.gui.control.UILabelFactory;
import dust.systems.ui.FrameRateView;
import dust.context.UnconfigConfig;
import dust.systems.impl.Systems;
import dust.type.TypeIndex;
import dust.gui.data.UIContainer;
import dust.entities.Entity;
import dust.gui.data.Alignment;
import dust.geom.data.Position;
import dust.gui.data.VAlign;
import dust.gui.data.HAlign;
import dust.systems.ui.SystemMetricsView;
import dust.systems.impl.SystemsList;
import dust.systems.impl.SystemMetrics;
import dust.entities.EntitiesConfig;
import dust.entities.Entities;
import dust.gui.GUIConfig;
import dust.context.DependentConfig;
import dust.context.Config;

import dust.Injector;

using dust.gui.GUIUtil;

class SystemMetricsConfig implements DependentConfig
{
    inline static var MEAN_DATA_POINTS = 25;
    inline static var OUTPUT_PRECISION = 4;

    @inject public var app:App;
    @inject public var injector:Injector;
    @inject public var entities:Entities;
    @inject public var systems:Systems;
    @inject public var labelFactory:UILabelFactory;

    var metrics:SystemMetrics;
    var list:SystemsList;
    var metricsView:Entity;
    var frameRateView:Entity;

    public function dependencies():Array<Class<Config>>
        return [EntitiesConfig, SystemsConfig, GUIConfig];

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
            entity.addView(new SystemMetricsView(labelFactory, metrics, OUTPUT_PRECISION));
            entity.add(new Alignment(HAlign.RIGHT, VAlign.BOTTOM));
            entity.add(new Position(app.stageWidth, app.stageHeight));
            return entity;
        }

        function makeFrameRateViewEntity()
        {
            var entity = entities.require();
            entity.addView(new FrameRateView(labelFactory));
            entity.add(new Alignment(HAlign.RIGHT, VAlign.TOP));
            entity.add(new Position(app.stageWidth, 0));
            return entity;
        }
}