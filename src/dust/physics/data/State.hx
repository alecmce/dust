package dust.physics.data;

import dust.geom.data.Position;
import dust.components.Component;

class State extends Component
{
    public var mass:Float;                  // kilograms
    public var inertiaTensor:Float;         // inertia tensor

    public var inverseMass:Float;           // 1 / mass
    public var inverseInertiaTensor:Float;  // 1 / inertia tensor

    public var positionX:Float;             // x-component of position
    public var positionY:Float;             // y-component of position
    public var rotation:Float;              // rotation

    public var momentumX:Float;             // x-component of momentum in kilogram meters per second
    public var momentumY:Float;             // y-component of momentum in kilogram meters per second
    public var angularMomentum:Float;       // angular momentum

    public var velocityX:Float;             // velocity in meters per second
    public var velocityY:Float;             // velocity in meters per second
    public var spin:Float;                  // angular velocity

    public function new()
    {
        mass = 1;
        inverseMass = 1;
        inertiaTensor = 1;
        inverseInertiaTensor = 1;

        momentumX = 0;
        momentumY = 0;
        angularMomentum = 0;

        velocityX = 0;
        velocityY = 0;
        spin = 0;
    }

    public function setPosition(position:Position):State
    {
        positionX = position.x;
        positionY = position.y;
        rotation = position.rotation;
        return this;
    }

    public function setVelocity(velocityX:Float, velocityY:Float, spin:Float):State
    {
        this.velocityX = velocityX;
        this.velocityY = velocityY;
        this.spin = spin;

        this.momentumX = velocityX * mass;
        this.momentumY = velocityY * mass;
        this.angularMomentum = spin * inertiaTensor;

        return this;
    }

    public function setMass(mass:Float):State
    {
        this.mass = mass;
        this.inverseMass = 1 / mass;

        this.momentumX = velocityX * mass;
        this.momentumY = velocityY * mass;
        this.angularMomentum = spin * inertiaTensor;

        return this;
    }

    public function setInteriaTensor(tensor:Float):State
    {
        this.inertiaTensor = tensor;
        this.inverseInertiaTensor = 1 / tensor;
        return this;
    }

    inline public function updateVelocityFromMomentum()
    {
        velocityX = momentumX * inverseMass;
        velocityY = momentumY * inverseMass;
        spin = angularMomentum * inverseInertiaTensor;
    }

    inline public function write(state:State)
    {
        state.mass = mass;
        state.inertiaTensor = inertiaTensor;

        state.inverseMass = inverseMass;
        state.inverseInertiaTensor = inverseInertiaTensor;

        state.positionX = positionX;
        state.positionY = positionY;
        state.rotation = rotation;

        state.momentumX = momentumX;
        state.momentumY = momentumY;
        state.angularMomentum = angularMomentum;

        state.velocityX = velocityX;
        state.velocityY = velocityY;
        state.spin = spin;
    }

    inline public function read(state:State)
    {
        state.write(this);
    }
}