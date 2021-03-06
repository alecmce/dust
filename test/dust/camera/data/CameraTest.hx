package dust.camera.data;

import dust.geom.data.Position;

class CameraTest
{
    var screenCenterX:Int;
    var screenCenterY:Int;

    var camera:Camera;
    var world:Position;
    var screen:Position;

    @Before public function before()
    {
        screenCenterX = Std.int(400);
        screenCenterY = Std.int(300);

        camera = new Camera(screenCenterX, screenCenterY);
        world = new Position();
        screen = new Position();
    }

    @Test public function cameraTranslatesWorldToScreen()
    {
        camera.set(20, 60);

        world.set(100, 100, 0);
        camera.toScreen(world, screen);

        Assert.areEqual(screenCenterX + 80, screen.x);
        Assert.areEqual(screenCenterY + 40, screen.y);
    }

    @Test public function cameraTranslatesWorldToScreenWithScale()
    {
        camera.set(20, 60);
        camera.scalar = 0.5;

        world.set(100, 100, 0);
        camera.toScreen(world, screen);

        Assert.areEqual(screenCenterX + 40, screen.x);
        Assert.areEqual(screenCenterY + 20, screen.y);
    }

    @Test public function cameraTranslatesScreenToWorld()
    {
        camera.set(20, 60);

        screen.set(screenCenterX + 80, screenCenterY + 40, 0);
        camera.toWorld(screen, world);

        Assert.areEqual(100, world.x);
        Assert.areEqual(100, world.y);
    }

    @Test public function cameraTranslatesScreenToWorldWithScale()
    {
        camera.set(20, 60);
        camera.scalar = 0.5;

        screen.set(screenCenterX + 40, screenCenterY + 20, 0);
        camera.toWorld(screen, world);

        Assert.areEqual(100, world.x);
        Assert.areEqual(100, world.y);
    }

}
