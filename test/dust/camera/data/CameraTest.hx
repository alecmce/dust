package dust.camera.data;

import massive.munit.Assert;
import dust.position.data.Position;

class CameraTest
{
    var screenCenterX:Int;
    var screenCenterY:Int;

    var camera:Camera;
    var world:Position;
    var screen:Position;

    @Before public function before()
    {
        var stage = nme.Lib.current.stage;
        screenCenterX = Std.int(stage.stageWidth * 0.5);
        screenCenterY = Std.int(stage.stageHeight * 0.5);

        camera = new Camera(screenCenterX, screenCenterY);
        world = new Position();
        screen = new Position();
    }

    @Test public function cameraTranslatesWorldToScreen()
    {
        camera.set(20, 60);

        world.set(100, 100);
        camera.toScreen(world, screen);

        Assert.areEqual(screenCenterX + 80, screen.x);
        Assert.areEqual(screenCenterY + 40, screen.y);
    }

    @Test public function cameraTranslatesWorldToScreenWithScale()
    {
        camera.set(20, 60);
        camera.scalar = 0.5;

        world.set(100, 100);
        camera.toScreen(world, screen);

        Assert.areEqual(screenCenterX + 40, screen.x);
        Assert.areEqual(screenCenterY + 20, screen.y);
    }

    @Test public function cameraTranslatesScreenToWorld()
    {
        camera.set(20, 60);

        screen.set(screenCenterX + 80, screenCenterY + 40);
        camera.toWorld(screen, world);

        Assert.areEqual(100, world.x);
        Assert.areEqual(100, world.y);
    }

    @Test public function cameraTranslatesScreenToWorldWithScale()
    {
        camera.set(20, 60);
        camera.scalar = 0.5;

        screen.set(screenCenterX + 40, screenCenterY + 20);
        camera.toWorld(screen, world);

        Assert.areEqual(100, world.x);
        Assert.areEqual(100, world.y);
    }

}
