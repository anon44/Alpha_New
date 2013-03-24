package NPC 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import Registry;
	import PlayState;
	/**
	 * This is the shooting human class
	 * 
	 */
	public class shooter extends FlxSprite
	{
		public var weapon:FlxWeapon;
		public var _gibs:FlxEmitter;
		public var _timer:Number;
		public var bounds:FlxRect;
		
		public function shooter(X:int , Y:int) 
		{
			super(X, Y);
			loadGraphic(GameAssets.imgHunter, true, true, 26, 25);
			solid = true;
			facing = FlxObject.LEFT;
			maxVelocity.x = 100;			//walking speed
			acceleration.y = 400;			//gravity
			drag.x = maxVelocity.x*4;		//deceleration (sliding to a stop)
			health = 1;
			
			//tweak the bounding box for better feel
		
			//Create the Weapon
			weapon = new FlxWeapon("weapon", this, "x", "y");
			weapon.setFiringPosition(this.x, this.y, 0, 0);
			bounds = new FlxRect(0, 0, FlxG.width+3000, FlxG.height+500);
			weapon.setBulletBounds(bounds);
			weapon.makeImageBullet(500, GameAssets.bullet, 5,5);
			weapon.bulletLifeSpan = 2000;
			weapon.setBulletSpeed(100);
			weapon.setFireRate(800);
			FlxG.state.add(weapon.group);
			
			//Create the animations
			addAnimation("idle", [10], 0);
			addAnimation("running", [2, 3, 4, 5, 6, 7, 8, 9], 10, true);
			addAnimation("killed", [0, 1], 3, false);
		}
		
		override public function update():void
		{
			super.update();
				//New code
				var a:Number = FlxVelocity.distanceBetween(this, Registry.followO);
				var b:Number = FlxVelocity.angleBetween(this, Registry.followO);
				if (a <= 75)
				{
					this.weapon.fireAtTarget(Registry.followO);//Making this the first elevator for now, later make to where it will shoot both of the elevators.
					if (b > -1 && facing == FlxObject.RIGHT)
					{
						velocity.x = -20;
						//facing = LEFT;
					}
					
					if (b > -45 && facing == FlxObject.LEFT)
					{
						velocity.x = 20;
						//facing = RIGHT;
					}
				}
			if (velocity.x > 0 || velocity.x < -1)
				play("running");
			else 
				play("idle");
		}

		override public function destroy():void
		{
			super.destroy();
			_gibs = null;
		}
		
		override public function kill():void
		{
			if (!alive)
				return;
			super.kill();
			alive = false;
			moves = false; 
			solid = false;
			play("killed");
			frame = 0;
			//Play sound 
			FlxG.play(GameAssets.humanHit, .75);
			
			//Gibs creator
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-150,170);
			_gibs.setYSpeed(-200,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 300;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.blood, 20, 10, true, 0.5);
			FlxG.state.add(_gibs);
			
			
			_gibs.x = this.x + width / 2;
			_gibs.x = this.y + height / 2;
			_gibs.recycle();
			//Gibs emitted upon death
			if (_gibs != null)
			{
				_gibs.at(this);
				_gibs.start(true, 5, 0, 40);
			}

			//End of Gibs creator
			FlxG.elapsed += _timer;
			if (_timer >= 5)
			{
				super.kill();
			}
		}// End of Kill
	}//End of Class
}//End of Package 