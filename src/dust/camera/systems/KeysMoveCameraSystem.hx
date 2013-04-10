package dust.camera.systems;

import dust.camera.data.Camera;
import dust.collections.api.Collection;
import dust.entities.api.Entity;
import dust.keys.impl.Keys;
import dust.systems.System;

import nme.ui.Keyboard;

class KeysMoveCameraSystem implements System
{
    inline static var DELTA:Float = 0.1;
    inline static var SCALAR_DELTA:Float = 0.01;

    @inject public var keys:Keys;
    @inject public var collection:Collection;

    public function new() {}
    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
            update(entity, deltaTime);
    }

        inline function update(entity:Entity, deltaTime:Float)
        {
            var camera:Camera = entity.get(Camera);
            camera.worldX += deltaTime * getDX(camera);
            camera.worldY += deltaTime * getDY(camera);
            camera.scalar *= 1 + deltaTime * getDScalar();
        }

            inline function getDX(camera:Camera)
                return (isLeft() + isRight()) * DELTA / camera.scalar

            inline function getDY(camera:Camera)
                return (isUp() + isDown()) * DELTA / camera.scalar

            inline function getDScalar()
                return (isZoomIn() + isZoomOut()) * SCALAR_DELTA

            inline function isLeft():Int
                return keys.isDown(Keyboard.A) ? 1 : 0

            inline function isRight():Int
                return keys.isDown(Keyboard.D) ? -1 : 0

            inline function isUp():Int
                return keys.isDown(Keyboard.W) ? 1 : 0

            inline function isDown():Int
                return keys.isDown(Keyboard.S) ? -1 : 0

            inline function isZoomIn():Int
                return keys.isDown(Keyboard.Q) ? 1 : 0

            inline function isZoomOut():Int
                return keys.isDown(Keyboard.E) ? -1 : 0
}
