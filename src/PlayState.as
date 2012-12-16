package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import Registry;
	
	public class PlayState extends FlxState
	{
		public var _background:FlxTilemap;
		public var _level:FlxTilemap;//Create the level
		
		public var _followObject:followObject;
		public var _elevators:FlxGroup;
		public var _elevator1:Elevator1
		public var _elevator2:Elevator2;
		public var _elevatorStart:FlxPoint = new FlxPoint( -75, 275);
		public var hitTest1:Boolean;
		public var hitTest2:Boolean;
		
		//Other Moving objects
		public var _cars:FlxGroup;
		public var _car:Car;
		public var _coinEmitter:FlxEmitter;
		public var _coin:Coin = new Coin;
		
		//Non-moving objects
		public var _trees:FlxGroup;
		public var _tree:Tree;
		public var totalTrees:int;
		public var _woodHouse:woodHouse;
		public var _woodHouses:FlxGroup;
		public var totalHouses:int
		public var _bunker:bunker;
		public var _exit:FlxSprite;
		
		//Player
		public var _player:Player;
		public var _humans:FlxGroup;
		public var _shooter:shooter;
		public var _humanReg:humanReg;
		
		//Other objects
		public var gameState:uint;
		private var healthBar:FlxBar;
		private var _lives:FlxBar;
		private var scoreText:FlxText;
		public var guiGroup:FlxGroup;
		
		//Timers
		private var hideGameMessageDelay:Number = 0;
		private var _counter:Number = 0;
		private var _counter2:Number = 0;
		private var _counter3:Number = 0;

		
		override public function create():void
		{
			//Background
			_background = new FlxTilemap();
			_background.loadMap(new GameAssets.backCSV, GameAssets.skyTilesPNG, 192, 336);
			add(_background);
			
			//Floor Tiles
			_level = new FlxTilemap();
			_level.loadMap(new GameAssets.mainCSV, GameAssets.mapTilesPNG, 16, 16, 0, 0, 1);
			_level.follow();
			add(_level);
			Registry.map = _level;
			/*End for background stuff*/
			
			
			/**
			 * Create the objects
			 */
			
			 //Trees
			 var _treemap:FlxTilemap = new FlxTilemap();
			_treemap.loadMap(new GameAssets.treeCSV, GameAssets.treePNG, 48, 48);
			_trees = new FlxGroup();
			for (var uy:int = 0; uy < _treemap.heightInTiles; uy++)
			{
				for (var ux:int = 0; ux < _treemap.widthInTiles; ux++)
				{
					if (_treemap.getTile(ux, uy) == 1)
					{
						_trees.add(new Tree(ux, uy));
						totalTrees++;
					}
				}
			}
			add(_trees);
			
			//Add the wood house
			_woodHouses = new FlxGroup();
			var _houses:Array = [
								new FlxPoint(1000,205),
								new FlxPoint(1700,205),
								new FlxPoint(1500,205)
								];
			
			for(var h:int = 0; h < _houses.length; h++)
			{
				_woodHouse = new woodHouse((_houses[h] as FlxPoint).x, (_houses[h] as FlxPoint).y);
				_woodHouses.add(_woodHouse);
				
			}
			add(_woodHouses);
			
			//Add Bunker 
			_bunker = new bunker(2500, 240);
			add(_bunker);
			
			//Add Cars
			_cars = new FlxGroup;
			for (var z:int = 0; z < 3; z++)
			{
				_car = new Car(FlxG.random() * 500+1500, 240);
				_cars.add(_car);
			}
			add(_cars);
				
			//Create the level exit, a dark gery box that is hidden at first
			_exit = new FlxSprite(2526, 270);//test
			_exit.makeGraphic(17, 24, 0xff3f3f3f);
			_exit.exists = false;
			add(_exit);
			
			 //Coins
			_coinEmitter = new FlxEmitter(0, 0, 20);
			_coinEmitter.gravity = 800;
			_coinEmitter.setRotation(0, 0);
			_coinEmitter.setXSpeed(-160, 160);
			_coinEmitter.setYSpeed( -200, -300);
			
			for (var i:int = 0; i < _coinEmitter.maxSize; i++)
			{
				_coinEmitter.add(new Coin);
			}
			add(_coinEmitter);
			/*End Objects*/
	
			
			/*
			 *Add the Humans
			 * */
			//Hunters
			_humans = new FlxGroup();
			
			for ( var y:int = 0; y < 15; y++)
			{
				_humanReg = new humanReg(FlxG.random() * 500 + 1300, 240);
				//_humanReg = new humanReg(200, 240);
				_humans.add(_humanReg);
				Registry._humanReg = _humanReg
			}
			for (var s:int = 0; s < 5; s++)
			{
				_shooter = new shooter(FlxG.random() * 500 + 1700, 240);
				_humans.add(_shooter);
				Registry._humanShooter = _shooter;
			}
			add(_humans);
	
			/*Add Enemies*/
			_elevators = new FlxGroup();
			_elevator1 = new Elevator1(_elevatorStart.x, _elevatorStart.y);
			_elevator2 = new Elevator2(_elevatorStart.x, _elevatorStart.y);
			
			_followObject  = new followObject(0, 255);
			Registry.followO = _followObject;
			_elevators.add(_elevator2);
			_elevators.add(_elevator1);
			
			add(_elevators);
			add(_followObject);	
			/*End Enemies*/
			
				
			//Add the Player
			_player = new Player(150, 220);
			Registry.player = _player;
			add(_player);
			
			 //Create the group
			 guiGroup = new FlxGroup();
			
			 //Create the hearts display
			var healthText:FlxText = new FlxText(0, 9, 100, "Health");
			healthText.color = 0xffffffff;
			
			//Make it scroll with the player
			healthText.scrollFactor.x = 0;
			healthText.scrollFactor.y = 0;  
			guiGroup.add(healthText);
			
			//Create the health bar
			healthBar = new FlxBar(40, 10, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, _player, "health", 0, 5);
			
			//Create the lives
			_lives = new FlxBar(FlxG.width / 2 +100, 10, FlxBar.FILL_LEFT_TO_RIGHT, 8, 8);
			_lives.createImageBar(null, GameAssets.heartPNG);//TODO: Need to fix this back ground to transparent
			_lives.setRange(0, 3);
			_lives.currentValue = 3;
			_lives.scrollFactor.x = 0;
			_lives.scrollFactor.y = 0;
			guiGroup.add(_lives);
			
			//Make it scroll with the player
			healthBar.scrollFactor.x = 0;
			healthBar.scrollFactor.y = 0;
			guiGroup.add(healthBar);
			
			//Score
			scoreText = new FlxText(155, 9, 100, "Score: 0");
			scoreText.color = 0xffffffff;
			scoreText.scrollFactor.x = 0;
			scoreText.scrollFactor.y = 0;
			guiGroup.add(scoreText);
			add(guiGroup);
			//End of GUI
	
			/**
			 * Add the camera
			 */
			FlxG.worldBounds = new FlxRect(0, 0, FlxG.width, FlxG.height);
			FlxG.camera.setBounds(0, 0, 2770, 336, true);
			FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);
		}//End of Create
		
		override public function update():void
		{
			super.update();
			//Collide
			FlxG.collide(_player, _level);
			FlxG.collide(_humans, _level);
			FlxG.collide(_cars, _level);
			FlxG.collide(_coinEmitter, _level);
		

			//This will pause the G's movement for at least three secs before the game starts.
			//We will need three counters to get this to work
			_counter += FlxG.elapsed;   // This first one will start everything
			_counter2 += FlxG.elapsed;  // The second one is control the first elevator
			_counter3 += FlxG.elapsed;  // The third one is control the second elevator
			//Number one will start first
			if (_counter > 2)
			{
				_elevator1.moves = true;    //This will go up first 
			}
			
			if (_elevator1.down == true)    //Check if the elevator is down 
			{
				hitTest1 = false;
				_elevator1.moves = false; //Then don't move
				if (_counter2 >= 4)      //After 4 seconds
				{
					hitTest1 = true;
					_elevator1.moves = true;
					_elevator1.down = false;
					_counter2 = 0;	
				}
			}
			
			if (_elevator2.down == true)//Check if the elevator is down 
			{
				hitTest2 = false;
				_elevator2.moves = false;//Then don't move
				if (_counter3 > 4 && _elevator1.down == true ) //After 4 seconds and only if the other evelator is down
				{
					hitTest2 = true;
					_elevator2.moves = true;
					_elevator2.down = false;
					_counter3 = 0;
				}
			}
			/**End of G*/
			//Overlap
			//Don't know why but this only works down here
			FlxG.overlap(_player, _coinEmitter, collectedCoin);
			FlxG.overlap(_player, _exit, win);
			FlxG.overlap(_elevators, _humans, killHuman);
			FlxG.overlap(_elevators, _cars, killHuman);
			FlxG.overlap(_elevators, _trees, hitTree);
			FlxG.overlap(_elevators, _woodHouses, killWood);
			FlxG.overlap(_elevators, _player, playerHits);
		}
		
			
		/**
		 * Call the private events 
		 * */
		/**
		 * When the player gets hit
		 */
		private function playerHits(_elevators:elevatorMain, _player:Player):void 
		{
			if (_player.y >= _elevators.y && hitTest1 == true || hitTest2 == true)//If the player is under the step
			{
				if (!_player.flickering)
				{
					_player.hit();
					hitTest1 = false;
					hitTest2 = false;
					if (_player.health <= 2)
					{
						healthBar.createFilledBar(0xff005100, 0xffc90606, false);
					}
					if (_player.health <= 0)
					{
						_player.kill();
						_lives.currentValue--;
						restart();
					}
				}
				
			}
			else
				_player.velocity.x += 40; //This can work for kicking movement for now 
		}//End of playerHits1
		
		//Collect Coin
		private function collectedCoin(player:FlxObject, coin:FlxObject):void
		{
			//FlxG.play(GameAssets.coinGet, 2);
			coin.kill();
			FlxG.score += 1;
			scoreText.text = "Score: " + FlxG.score.toString();
			if (FlxG.score >= 10)
			{
				_bunker.frame = 1;
				_exit.exists = true;
			}
		}

		//Kill the Tress
		private	function hitTree(elevators:FlxObject, tree:FlxObject):void
		{
			tree.kill();
			_coinEmitter.x = tree.x;
			_coinEmitter.y = tree.y;
			_coinEmitter.start(true, 0, 0, 2);
			
		}
		//Kill the wood blocks
		private	function killWood(_elevators:FlxObject, _woodHouse:FlxObject):void
		{
			_woodHouse.kill();
			_coinEmitter.x = _woodHouse.x+50;
			_coinEmitter.y = _woodHouse.y;
			_coinEmitter.start(true, 0, 0, 15);
			
		}
		
		//Kill the Humans
		private function killHuman(_elevators:FlxObject, _humanReg:FlxObject):void
		{
			_humanReg.kill();
			_coinEmitter.x = _humanReg.x;
			_coinEmitter.y = _humanReg.y;
			_coinEmitter.start(true, 0, 0, 3);
			_coinEmitter.lifespan = 50;
		}
		
		private function killShooter(_elevators:FlxObject, _shooter:FlxObject):void
		{
			_shooter.kill();
			_coinEmitter.x = _shooter.x;
			_coinEmitter.y = _shooter.y;
			_coinEmitter.start(true, 0, 0, 5);
		}
		
		private function killCar(_elevators:FlxObject, _car:FlxObject):void
		{
			_car.kill()
			_coinEmitter.x = _car.x;
			_coinEmitter.y = _car.y;
			_coinEmitter.start(true, 0, 0, 4);
		}
		
		//Reset the state if the player dies
		private function restart():void
		{
			//Make sure the player still has lives to restart
			if (_lives.currentValue == 0)
			{
				FlxG.fade(0xff000000, 2, gameOver);
			}
			else //Restart the player
			{
				healthBar.createFilledBar(0xff005100, 0xff00F400, false);
				_player.health = 5;
				_player.flicker(2);
				_player.reset(_elevator1.x + Math.random()*150, 200);
			}
		}
		
		//This is called when the game is over 
		private function gameOver():void
		{
			FlxG.switchState(new GameOver());
		}
		
		//Called whenever the player touches the exit
		private function win(exit:FlxObject, Player:FlxObject):void 
		{
			//change the playstate
			Player.kill();
			FlxG.switchState(new GameOver());
		}
		
		override public function destroy():void
		{
			//	Important! Clear out the plugin otherwise resources will get messed right up after a while
			FlxControl.clear();
			super.destroy();
		}
	}
}

