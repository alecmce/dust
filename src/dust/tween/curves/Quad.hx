package dust.tween.curves;

class Quad
{
	
	inline public static function easeIn(p:Float):Float
	{
		return p * p;
	}

	inline public static function easeOut(p:Float):Float
	{
		return -p * (p - 2);
	}

	inline public static function easeInOut(p:Float):Float
	{
		var n = 0.0;

		if ((p *= 2) < 1)
			n = .5 * p * p;
		else
			n = -.5 * ((--p) * (p - 2) - 1);
		
		return n;
	}
	
}