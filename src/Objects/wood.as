package Objects 
{
	 /** Add two different sounds for crush
	 * 
	 * 
	 * 
	 * */
	
	import org.flixel.*;
	import GameAssets;
	import PlayState;
	
	public class wood extends FlxSprite
	{
		public var _timer:Number;
		public var _gibs:FlxEmitter; //Gibs to emit whe that object is destoryed 
		public var _gibs2:FlxEmitter; //Another gib to emit more little objects
		
		public function wood(X:int, Y:int)
		{
			super(X*16, Y*16);
			loadGraphic(GameAssets.woodPNG, true, false, 16, 16);
			solid = true;
			frame = 1;
		}

		override public function update():void
		{
			acceleration.x = 0;
			super.update();
		}
		
		/**
		 * Destory object 
		 */
		override public function destroy():void
		{
			super.destroy();
			_gibs = null;
		}
		
		/**
		 * When the tree gets killed
		 */
		override public function kill():void
		{
			if (!alive)
				return;
			frame = 2; 

			solid = false;
			moves = false;
			
			//FlxG.play(GameAssets.stompTree, .35);
			//Coins
			//cE =   new coinEmitter(this.x, this.y);
			//cE.start(true, 0, 0, 1);
			//FlxG.state.add(cE);
			
			//Gibs creator
			//Gibs creator for the leafs
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-50,50);
			_gibs.setYSpeed(-100,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 100;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.woodBits, 10, 10, false, 0.5); // //TODOCreate sprite
			FlxG.state.add(_gibs);
			
			_gibs.x = this.x + width / 2;
			_gibs.x = this.y + height / 2;
			_gibs.recycle();
			_gibs.at(this);
			_gibs.start(true, 3, 0, 15);
			//Gibs emitted upon death
			if (_gibs != null)
			{
				_gibs.at(this);
				_gibs.start(true, 3, 0, 15);
			}
			
			//Gibs for the bark and Sticks
			_gibs2 = new FlxEmitter(0,0, -1.5);
			_gibs2.setXSpeed(-50,50);
			_gibs2.setYSpeed(-100,0);
			_gibs2.setRotation(-720,-720);
			_gibs2.gravity = 100;
			_gibs2.bounce = 0.1; 
			_gibs2.makeParticles(GameAssets.barkBits, 10, 10, false, 0.5); 
			FlxG.state.add(_gibs2);
			
			
			_gibs2.x = this.x + width / 2;
			_gibs2.x = this.y + height / 2;
			_gibs2.recycle();
			
			//Gibs emitted upon death
			if (_gibs2 != null)
			{
				_gibs2.at(this);
				_gibs2.start(true, 3, 0, 4);
				
			}
			//End of Gibs creator
			FlxG.elapsed += _timer;
			
			if (_timer >= 5)
			{
				super.kill();
			}
		}
		
	}//End of Class

}//End of Package