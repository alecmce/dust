package dust.tween.curves;

class Bounce
{

	inline public static function easeOut(p:Float):Float
	{
		var n = 0.0;
		
		if (p < .36363636)
			n = 7.5625 * p * p;
		else if (p < .72727272)
			n = 7.5625 * (p -= .54545454) * p + .75;
		else if (p < .90909090)
			n = 7.5625 * (p -= .81818181) * p + .9375;
		else
			n = 7.5625 * (p -= .95454545) * p + .984375;
		
		return n;
	}

	inline public static function easeIn(p:Float):Float
	{
		return 1 - easeOut(1 - p);
	}

	inline public static function easeInOut(p:Float):Float
	{
		var n = 0.0;

		if (p < .5)
			n = easeIn(p * 2) * .5;
		else
			n = (easeOut(p * 2 - 1) + 1) * .5;
		
		return n;
	}
}