package dust.tween.curves;

class Quint
{

	inline public static function easeIn(p:Number):Number
	{
		return p * p * p * p * p;
	}

	inline public static function easeOut(p:Number):Number
	{
		return (p -= 1) * p * p * p * p + 1;
	}

	inline public static function easeInOut(p:Number):Number
	{
		var n = 0.0;
		
		if ((p *= 2) < 1)
			n = .5 * p * p * p * p * p;
		else
			n = .5 * ((p -= 2) * p * p * p * p + 2);
		
		return n;
	}
	
}