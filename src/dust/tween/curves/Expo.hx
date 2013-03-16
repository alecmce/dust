package dust.tween.curves;

class Expo
{

	inline public static function easeIn(p:Float):Float
	{
		return p == 0 ? 0 : Math.pow(2, 10 * (p - 1)) - 0.001;
	}

	inline public static function easeOut(p:Float):Float
	{
		return p == 1 ? 1 : -Math.pow(2, -10 * p) + 1;
	}

	inline public static function easeInOut(p:Float):Float
	{
		var n = 0.0;

		if (p == 0 || p == 1)
			n = p;
		else if ((p *= 2) < 1)
			n = .5 * Math.pow(2, 10 * (p - 1));
		else
			n = .5 * (-Math.pow(2, -10 * (p - 1)) + 2);
		
		return n;
	}
	
}