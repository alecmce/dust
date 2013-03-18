package dust.quadtree.eg;

import dust.type.TypeIndex;
import dust.systems.impl.SystemMetrics;
import dust.camera.data.Camera;
import dust.canvas.data.Paint;
import dust.canvas.data.PrioritizedPainter;
import dust.canvas.PrioritizedPaintersConfig;
import dust.components.Component;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.collections.api.Collection;
import dust.entities.api.Entity;
import dust.entities.api.Entities;
import dust.entities.EntitiesConfig;
import dust.math.MathConfig;
import dust.math.Random;
import dust.geom.Position;
import dust.systems.impl.Systems;
import dust.systems.System;
import dust.systems.SystemsConfig;
import dust.systems.SystemMetricsConfig;
import dust.quadtree.data.QuadTree;
import dust.quadtree.data.QuadTreeRange;
import dust.quadtree.ui.QuadTreePainter;

class QuadTreeVisualizationExample implements DependentConfig
{
    inline public static var COUNT = 200;
    inline public static var EXTENT = 400;
    inline public static var DELTA = 1;

    @inject public var entities:Entities;
    @inject public var systems:Systems;
    @inject public var camera:Camera;
    @inject public var random:Random;
    @inject public var metrics:SystemMetrics;

    var range:QuadTreeRange;
    var tree:QuadTree<Entity>;

    public function dependencies():Array<Class<Config>>
        return [MathConfig, EntitiesConfig, SystemsConfig, SystemMetricsConfig, PrioritizedPaintersConfig]

    public function configure()
    {
        range = new QuadTreeRange(new Position(0, 0), EXTENT);
        tree = new QuadTree<Entity>(range, 1, 0.001);

        systems
            .map(MovingPositionsSystem)
            .toCollection([Position, MovingPositionDelta])
            .withName("MovingPositions");

        systems
            .map(UpdateQuadTreesSystem)
            .toCollection([QuadTree])
            .withName("UpdateQuadTrees")
            .withMetrics(metrics);

        makeTreeVisualization();
        makePositions();
    }

        function makeTreeVisualization()
        {
            var paint = new Paint().setLine(1, 0xFFFFFF);
            var painter = new QuadTreePainter(paint);
            var priority = new PrioritizedPainter(painter, 1);

            var entity = entities.require();
            entity.add(tree);
            entity.add(camera);
            entity.add(priority);
            return entity;
        }

        function makePositions()
        {
            for (i in 0...COUNT)
                makePosition();
        }

        function makePosition()
        {
            var x = random.floatInRange(-EXTENT, EXTENT);
            var y = random.floatInRange(-EXTENT, EXTENT);
            var position = new Position(x, y);

            var paint = new Paint().setLine(1, 0xFF0000);
            var painter = new CrossPositionPainter(paint);
            var priority = new PrioritizedPainter(painter, 2);

            var dx = random.floatInRange(-DELTA, DELTA);
            var dy = random.floatInRange(-DELTA, DELTA);
            var delta = new MovingPositionDelta(dx, dy);

            var entity = entities.require();
            entity.add(position);
            entity.add(camera);
            entity.add(priority);
            entity.add(delta);

            tree.add(position, entity);
        }
}