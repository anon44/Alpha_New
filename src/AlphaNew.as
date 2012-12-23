package

{

	import org.flixel.*;

	[SWF(width="640", height="480", backgroundColor="#000000")]

	[Frame(factoryClass="Preloader")]



	public class AlphaNew extends FlxGame

	{

		public function AlphaNew()

		{

			super(320,240,MenuState,2, 60, 60);
			forceDebugger = true;
		}

	}

}

