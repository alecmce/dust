package dust.physics.eg;

import dust.graphics.data.Paint;
import dust.graphics.data.Painter;
import dust.physics.data.Box;
import dust.graphics.PaintersConfig;
import dust.physics.data.forces.DistanceSpring;
import dust.physics.data.Physics;
import dust.physics.data.State;
import dust.camera.data.Camera;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.api.Entities;
import dust.entities.api.Entity;
import dust.geom.data.Position;
import dust.math.MathConfig;
import dust.math.Random;
import dust.math.trig.Trig;
import dust.systems.SystemMetricsConfig;

class PhysicsExample implements DependentConfig
{
    inline static function quarterTurn():Float return Math.PI / 4

    @inject public var entities:Entities;
    @inject public var camera:Camera;
    @inject public var random:Random;
    @inject public var trig:Trig;

    public function dependencies():Array<Class<Config>>
        return [PaintersConfig, PhysicsConfig, MathConfig, SystemMetricsConfig]

    public function configure()
    {
        var aPosition = new Position(100, 0);
        var bPosition = new Position(-100, 0);

        var aState = makeState(aPosition, 1);
        var bState = makeState(bPosition, 1);

        var aPainter = new BoxPainter(new Paint().setFill(0xFF0000), trig);
        var bPainter = new BoxPainter(new Paint().setFill(0xFF8800), trig);

        var forces = makePhysics();

        var a = entities.require();
        a.add(aPosition);
        a.add(camera);
        a.add(new Box(60));
        a.addAsType(aPainter, Painter);
        a.add(aState);
        a.add(forces.a);

        var b = entities.require();
        b.add(bPosition);
        b.add(camera);
        b.add(new Box(60));
        b.addAsType(bPainter, Painter);
        b.add(bState);
        b.add(forces.b);

        camera.scalar = 1;
    }

        function makeState(position:Position, mass:Float):State
        {
            return new State()
                .setPosition(position)
                .setMass(mass);
        }

        function makePhysics():{a:Physics, b:Physics}
        {
            var a = new Physics();
            var b = new Physics();

            var aDistanceSpring = new DistanceSpring(b);
            aDistanceSpring.restDistance = 100;
            aDistanceSpring.tightness = 100;
            aDistanceSpring.dampingCoefficient = 100;
            a.addForce(aDistanceSpring);

            var bDistanceSpring = new DistanceSpring(a);
            bDistanceSpring.restDistance = 100;
            bDistanceSpring.tightness = 100;
            bDistanceSpring.dampingCoefficient = 100;
            b.addForce(bDistanceSpring);

            return {a:a, b:b};
        }
}
