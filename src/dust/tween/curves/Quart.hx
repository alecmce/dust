package dust.tween.curves;

class Quart
{

	inline public static function easeIn(p:Float):Float
	{
		return p * p * p * p;
	}

	inline public static function easeOut(p:Float):Float
	{
		return -((p -= 1) * p * p * p - 1);
	}

	inline public static function easeInOut(p:Float):Float
	{
		var n = 0.0;

		if ((p *= 2) < 1)
			n = .5 * p * p * p * p;
		else
			n = -.5 * ((p -= 2) * p * p * p - 2);
		
		return n;
	}
	
}