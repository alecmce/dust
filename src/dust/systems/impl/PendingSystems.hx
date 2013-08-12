package dust.systems.impl;

class PendingSystems
{
    var loop:SystemsLoop;

    var isPending:Bool;
    var list:Array<SystemMapping>;

    public function new(loop:SystemsLoop)
    {
        this.loop = loop;

        isPending = false;
        list = new Array<SystemMapping>();
    }

    public function add(pending:SystemMapping)
    {
        isPending = true;
        list.push(pending);
    }

    public function update()
    {
        if (isPending)
        {
            for (pending in list)
                pending.apply(loop);

            isPending = false;
            untyped list.length = 0;
        }
    }
}
