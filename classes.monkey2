Global splash:Splash
Global menu:Menu
Global settings:Settings
Global gamesetup:GameSetup
Global game:Game
Global sendfleet:SendFleet
Global combat:Combat
Global reinforcements:Reinforcements
Global showfleets:Fleets
Global showplanets:Planets
Global gameover:GameOver

Class Empire Extends ScreenManager
	Method New( title:String,width:Int,height:Int,flags:WindowFlags=Null )
		Super.New( title,width,height,flags )
		splash = New Splash
		menu = New Menu
		settings = New Settings
		gamesetup = New GameSetup
		game = New Game
		sendfleet = New SendFleet
		combat = New Combat
		reinforcements = New Reinforcements
		showfleets = New Fleets
		showplanets = New Planets
		gameover = New GameOver
		
		splash.Set()
	End Method	
End Class

Class Splash Extends Screen
	Field TimeToFade:Int = 300

	Field tmpalpha:Float = 1.0
	Field tickcount:Int
	
	Field timer:Timer 
	
	Method RunOnce() Override
		Print "Splash initialized"
	End

	Method OnKeyEvent( event:KeyEvent ) Override
	End

	Method OnMouseEvent( event:MouseEvent ) Override
	End

	Method OnStart() Override
		SetTimer(60)
	End

	Method OnStop() Override
		timer.Cancel()
	End

	Method OnRender( canvas:Canvas ) Override
		canvas.DrawImage(starfield, 0, 0)
		canvas.Font = arialblk72
		canvas.Color = New Color(1.0,1.0,0.0,1.0)
		canvas.Alpha = tmpalpha 
		canvas.DrawText("GALACTIC EMPIRE", SCREEN_WIDTH / 2, 200, 0.5, 0.5)
		canvas.Font = arial24
		canvas.DrawText("Copyright 2018 - STONEhenge Software", SCREEN_WIDTH / 2, 300, 0.5, 0.5)
		canvas.DrawText("Based on the C64 game by Paul Kellam", SCREEN_WIDTH / 2, 350, 0.5, 0.5)
		canvas.Alpha = 1.0		
	End

	Method OnUpdate() Override
		If Keyboard.KeyHit( Key.Space )
			menu.Set()
		Endif
	End

	Method Tick() 
		If tickcount > TimeToFade Then
		tmpalpha -= 0.05
			If tmpalpha < 0 Then 
				tmpalpha = 0.0
				timer.Suspended = True
				menu.Set()
			Endif
		Endif
		tickcount += 1
	End Method
	
	Method SetTimer(hz:Int)
		timer = New Timer(hz, Tick)		
	End Method
End Class 

Class Menu Extends Screen
	Field btnNewGame:GuiButton
	Field btnLoadGame:GuiButton
	Field btnSaveGame:GuiButton
	Field btnOptions:GuiButton
	Field btnQuit:GuiButton
	Field layer:GuiLayer
	
	Method OnStart() Override

	End

	Method OnStop() Override

	End

	Method OnRender( canvas:Canvas ) Override
		canvas.DrawImage(starfield, 0, 0)
		
		layer.Update()
		layer.Draw(canvas)
	End

	Method OnUpdate() Override
		If btnNewGame.Released Then 
			btnNewGame.Released = False
			gamesetup.Set()			
		Endif

		If btnQuit.Released Then 
			App.Terminate()		
		Endif
	End

	Method RunOnce() Override
		SetupGUI()
	End
		
	Method SetupGUI()
		layer = New GuiLayer(ScreenManager)
		
		btnNewGame = New GuiButton
		btnNewGame.Layer = layer
		btnNewGame.Location = New Vec2f(SCREEN_WIDTH/2, 200)
		btnNewGame.Width = 300
		btnNewGame.Height = 40
		btnNewGame.Font = arial24
		btnNewGame.Text = "New Game"
		btnNewGame.Surface.PatchData=New Int[](8)
		btnNewGame.Surface.DrawData( GuiState.Idle ).Image=Image.Load( "asset::button300x40.png" )		
		btnNewGame.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnNewGame.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnNewGame.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnNewGame.Label.DrawData( GuiState.Down ).Scale=btnNewGame.Surface.DrawData( GuiState.Down ).Scale
		
		btnLoadGame = New GuiButton
		btnLoadGame.Layer = layer
		btnLoadGame.Location = New Vec2f(SCREEN_WIDTH/2, 250)
		btnLoadGame.Width = 300
		btnLoadGame.Height = 40
		btnLoadGame.Font = arial24
		btnLoadGame.Text = "Load Game"
		btnLoadGame.Surface.PatchData=New Int[](8)
		btnLoadGame.Surface.DrawData( GuiState.Idle ).Image=Image.Load( "asset::button300x40.png" )		
		btnLoadGame.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnLoadGame.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnLoadGame.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnLoadGame.Label.DrawData( GuiState.Down ).Scale=btnLoadGame.Surface.DrawData( GuiState.Down ).Scale	
		
		btnSaveGame = New GuiButton
		btnSaveGame.Layer = layer
		btnSaveGame.Location = New Vec2f(SCREEN_WIDTH/2, 300)
		btnSaveGame.Width = 300
		btnSaveGame.Height = 40
		btnSaveGame.Font = arial24
		btnSaveGame.Text = "Save Game"
		btnSaveGame.Surface.PatchData=New Int[](8)
		btnSaveGame.Surface.DrawData( GuiState.Idle ).Image=Image.Load( "asset::button300x40.png" )		
		btnSaveGame.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnSaveGame.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnSaveGame.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnSaveGame.Label.DrawData( GuiState.Down ).Scale=btnSaveGame.Surface.DrawData( GuiState.Down ).Scale	
		
		btnOptions = New GuiButton
		btnOptions.Layer = layer
		btnOptions.Location = New Vec2f(SCREEN_WIDTH/2, 350)
		btnOptions.Width = 300
		btnOptions.Height = 40
		btnOptions.Font = arial24
		btnOptions.Text = "Options"
		btnOptions.Surface.PatchData=New Int[](8)
		btnOptions.Surface.DrawData( GuiState.Idle ).Image=Image.Load( "asset::button300x40.png" )		
		btnOptions.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnOptions.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnOptions.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnOptions.Label.DrawData( GuiState.Down ).Scale=btnOptions.Surface.DrawData( GuiState.Down ).Scale		

		btnQuit = New GuiButton
		btnQuit.Layer = layer
		btnQuit.Location = New Vec2f(SCREEN_WIDTH/2, 400)
		btnQuit.Width = 300
		btnQuit.Height = 40
		btnQuit.Font = arial24
		btnQuit.Text = "Quit"
		btnQuit.Surface.PatchData=New Int[](8)
		btnQuit.Surface.DrawData( GuiState.Idle ).Image=Image.Load( "asset::button300x40.png" )		
		btnQuit.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnQuit.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnQuit.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnQuit.Label.DrawData( GuiState.Down ).Scale=btnQuit.Surface.DrawData( GuiState.Down ).Scale	
	End Method	
End Class 

Class Settings Extends Screen
	
End Class 

Class GameSetup Extends Screen
	Field layer:GuiLayer
	
	Field lblName:GuiLabel
	Field btnNumPlanets:GuiButton		'won't be clicked...  just for label + image purposes
	Field btnMinProduction:GuiButton
	Field btnMaxProduction:GuiButton
	Field txtName:GuiInputBox
	Field btnSubPlanets:GuiButton
	Field lblPlanets:GuiLabel
	Field btnAddPlanets:GuiButton
	Field btnSubMin:GuiButton
	Field lblMinProd:GuiLabel
	Field btnAddMin:GuiButton
	Field btnSubMax:GuiButton
	Field lblMaxProd:GuiLabel
	Field btnAddMax:GuiButton
	Field btnSubTurn:GuiButton
	Field btnAddTurn:GuiButton
	Field btnTurns:GuiButton
	Field lblTurns:GuiLabel
	Field btnGenerate:GuiButton
	Field btnCancel:GuiButton
	Field btnStart:GuiButton

	Field Pname:String = "Player 1"
	Field NumPlanets:Int = MaxPlanets
	Field NumTurns:Int = MaxTurns
	Field MinProd:Int = MinProduction
	Field MaxProd:Int = MaxProduction
	Field MapGenerated:Bool = False
	
	Method OnStart() Override
		
	End

	Method OnStop() Override
		
	End

	Method OnRender( canvas:Canvas ) Override
		canvas.Color = New Color(RGB * 100, RGB * 100, RGB * 100, 1)
		canvas.DrawImage(starfield, 0, 0)
		canvas.Color = Color.White

		'draw minimap 374 x 210 with 5 pixel margins
		canvas.Color = Color.Black
		canvas.OutlineMode = OutlineMode.Solid
		canvas.OutlineColor = Color.White
		canvas.DrawRect(SCREEN_WIDTH/2 - 247, 540, 494, 280)
		canvas.OutlineMode = OutlineMode.None
		canvas.Color = Color.White
		
		If MapGenerated Then 
			Local tmpcolor:Color = canvas.Color
			For Local tmp:Planet = Eachin GameMap.Planets
				canvas.Color = tmp.OwnerColor
				canvas.DrawPoint(SCREEN_WIDTH/2 - 242 + tmp.MapX, 565 + tmp.MapY)
			Next				
			canvas.Color = tmpcolor
		Endif
		
		layer.Update()
		layer.Draw(canvas)
	End

	Method OnUpdate() Override
		If Keyboard.KeyReleased(Key.Escape) Or btnCancel.Released Then 
			menu.Set()
		Endif

		If btnSubPlanets.Released Then 
			NumPlanets -= 5
			If NumPlanets < 10 NumPlanets = 10
			btnNumPlanets.Text = NumPlanets								
		Endif
		
		If btnAddPlanets.Released Then 
			NumPlanets += 5
			If NumPlanets > 100 NumPlanets = 100
			btnNumPlanets.Text = NumPlanets				
		Endif
		
		If btnSubMin.Released Then 
			MinProd -= 1
			If MinProd < 0 MinProd = 0
			btnMinProduction.Text = MinProd				
			btnMaxProduction.Text = MaxProd	
		Endif

		If btnAddMin.Released Then 
			MinProd += 1
			If MinProd > 20 MinProd = 20
			If MaxProd < MinProd MaxProd = MinProd
			btnMinProduction.Text = MinProd				
			btnMaxProduction.Text = MaxProd	
		Endif
		If btnSubMax.Released Then 
			MaxProd -= 1
			If MaxProd < MinProd MaxProd = MinProd
			btnMinProduction.Text = MinProd				
			btnMaxProduction.Text = MaxProd	
		Endif

		If btnAddMax.Released Then 
			MaxProd += 1
			If MinProd > 50 MinProd = 50
			btnMinProduction.Text = MinProd				
			btnMaxProduction.Text = MaxProd	
		Endif

		If btnSubTurn.Released Then 
			NumTurns -= 25
			If NumTurns < 10 NumTurns = 10
			btnTurns.Text = NumTurns				
		Endif

		If btnAddTurn.Released Then 
			NumTurns += 25
			If NumTurns > 1000 NumTurns = 1000
			btnTurns.Text = NumTurns				
		Endif
		
		If btnGenerate.Released Then 
			GameMap.MinProduction = MinProd
			GameMap.MaxProduction = MaxProd
			GameMap.GenerateMap(470,252,4,4,16,16,NumPlanets)	
			MapGenerated = True			
		Endif
		
		If btnStart.Released Then 
			GameMap.MaxTurns = NumTurns
			If Not MapGenerated Then 
				GameMap.MinProduction = MinProd
				GameMap.MaxProduction = MaxProd
				GameMap.GenerateMap(470,252,4,4,16,16,NumPlanets)	
				MapGenerated = True						
			Endif
			game.Set()
		Endif
	End

	Method RunOnce() Override
		SetupGUI()
	End
	
	Method SetupGUI()
		layer = New GuiLayer(ScreenManager)

		lblName = New GuiLabel
		lblName.Layer = layer				
		lblName.Location = New Vec2f(SCREEN_WIDTH/2 - 200, 250)
		lblName.Handle = New Vec2f(1,0)
		lblName.Width = arial24.TextWidth("Player Name")
		lblName.Height = 40
		lblName.Font = arial24
		lblName.Text = "Player Name"
		
		lblName = New GuiLabel
		lblName.Layer = layer				
		lblName.Location = New Vec2f(SCREEN_WIDTH/2 - 200, 300)
		lblName.Handle = New Vec2f(1,0)
		lblName.Width = arial24.TextWidth("Number of Planets")
		lblName.Height = 40
		lblName.Font = arial24
		lblName.Text = "Number of Planets"
		
		lblName = New GuiLabel
		lblName.Layer = layer				
		lblName.Location = New Vec2f(SCREEN_WIDTH/2 - 200, 350)
		lblName.Handle = New Vec2f(1,0)
		lblName.Width = arial24.TextWidth("Minimum Production")
		lblName.Height = 40
		lblName.Font = arial24
		lblName.Text = "Minimum Production"
		
		lblName = New GuiLabel
		lblName.Layer = layer				
		lblName.Location = New Vec2f(SCREEN_WIDTH/2 - 200, 400)
		lblName.Handle = New Vec2f(1,0)
		lblName.Width = arial24.TextWidth("Maximum Production")
		lblName.Height = 40
		lblName.Font = arial24
		lblName.Text = "Maximum Production"

		lblName = New GuiLabel
		lblName.Layer = layer				
		lblName.Location = New Vec2f(SCREEN_WIDTH/2 - 200, 450)
		lblName.Handle = New Vec2f(1,0)
		lblName.Width = arial24.TextWidth("Game Turns")
		lblName.Height = 40
		lblName.Font = arial24
		lblName.Text = "Game Turns"

		txtName = New GuiInputBox
		txtName.Layer = layer
		txtName.Width = 300
		txtName.Height = 40
		txtName.Handle = New Vec2f(0,0)
		txtName.Location = New Vec2f( SCREEN_WIDTH/2 - 150, 240)
		txtName.Border = 40
		txtName.Surface.PatchData = New Int[](8)
		txtName.Surface.DrawData( GuiState.Idle ).Image = btn300x40
		txtName.Text = Pname
		txtName.Font = arial24								
		
		btnSubMin = New GuiButton
		btnSubMin.Layer = layer
		btnSubMin.Location = New Vec2f(SCREEN_WIDTH/2 - 150, 340)
		btnSubMin.Width = 40
		btnSubMin.Height = 40
		btnSubMin.Handle = New Vec2f(0,0)		
		btnSubMin.Font = arial24
		btnSubMin.Text = "-"
		btnSubMin.Surface.PatchData=New Int[](8)
		btnSubMin.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnSubMin.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnSubMin.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnSubMin.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnSubMin.Label.DrawData( GuiState.Down ).Scale=btnSubMin.Surface.DrawData( GuiState.Down ).Scale	

		btnMinProduction = New GuiButton
		btnMinProduction.Layer = layer				
		btnMinProduction.Location = New Vec2f(SCREEN_WIDTH/2 - 100, 340)
		btnMinProduction.Width = 200
		btnMinProduction.Height = 40
		btnMinProduction.Handle = New Vec2f(0,0)
		btnMinProduction.Font = arial24
		btnMinProduction.Text = MinProduction
		btnMinProduction.Surface.DrawData( GuiState.Idle ).Image=btn200x40

		btnAddMin = New GuiButton
		btnAddMin.Layer = layer
		btnAddMin.Location = New Vec2f(SCREEN_WIDTH/2 + 110, 340)
		btnAddMin.Width = 40
		btnAddMin.Height = 40
		btnAddMin.Handle = New Vec2f(0,0)		
		btnAddMin.Font = arial24
		btnAddMin.Text = "+"
		btnAddMin.Surface.PatchData=New Int[](8)
		btnAddMin.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnAddMin.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnAddMin.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnAddMin.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnAddMin.Label.DrawData( GuiState.Down ).Scale=btnAddMin.Surface.DrawData( GuiState.Down ).Scale
		
		btnSubMax = New GuiButton
		btnSubMax.Layer = layer
		btnSubMax.Location = New Vec2f(SCREEN_WIDTH/2 - 150, 390)
		btnSubMax.Width = 40
		btnSubMax.Height = 40
		btnSubMax.Handle = New Vec2f(0,0)		
		btnSubMax.Font = arial24
		btnSubMax.Text = "-"
		btnSubMax.Surface.PatchData=New Int[](8)
		btnSubMax.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnSubMax.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnSubMax.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnSubMax.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnSubMax.Label.DrawData( GuiState.Down ).Scale=btnSubMax.Surface.DrawData( GuiState.Down ).Scale	

		btnMaxProduction = New GuiButton
		btnMaxProduction.Layer = layer				
		btnMaxProduction.Location = New Vec2f(SCREEN_WIDTH/2 - 100, 390)
		btnMaxProduction.Width = 200
		btnMaxProduction.Height = 40
		btnMaxProduction.Handle = New Vec2f(0,0)
		btnMaxProduction.Font = arial24
		btnMaxProduction.Text = MaxProduction
		btnMaxProduction.Surface.DrawData( GuiState.Idle ).Image=btn200x40
		
		btnAddMax = New GuiButton
		btnAddMax.Layer = layer
		btnAddMax.Location = New Vec2f(SCREEN_WIDTH/2 + 110, 390)
		btnAddMax.Width = 40
		btnAddMax.Height = 40
		btnAddMax.Handle = New Vec2f(0,0)		
		btnAddMax.Font = arial24
		btnAddMax.Text = "+"
		btnAddMax.Surface.PatchData=New Int[](8)
		btnAddMax.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnAddMax.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnAddMax.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnAddMax.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnAddMax.Label.DrawData( GuiState.Down ).Scale=btnAddMax.Surface.DrawData( GuiState.Down ).Scale		

		btnSubPlanets = New GuiButton
		btnSubPlanets.Layer = layer
		btnSubPlanets.Location = New Vec2f(SCREEN_WIDTH/2 - 150, 290)
		btnSubPlanets.Width = 40
		btnSubPlanets.Height = 40
		btnSubPlanets.Handle = New Vec2f(0,0)		
		btnSubPlanets.Font = arial24
		btnSubPlanets.Text = "-"
		btnSubPlanets.Surface.PatchData=New Int[](8)
		btnSubPlanets.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnSubPlanets.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnSubPlanets.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnSubPlanets.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnSubPlanets.Label.DrawData( GuiState.Down ).Scale=btnSubPlanets.Surface.DrawData( GuiState.Down ).Scale	

		btnNumPlanets = New GuiButton
		btnNumPlanets.Layer = layer				
		btnNumPlanets.Location = New Vec2f(SCREEN_WIDTH/2 - 100, 290)
		btnNumPlanets.Width = 200
		btnNumPlanets.Height = 40
		btnNumPlanets.Handle = New Vec2f(0,0)
		btnNumPlanets.Font = arial24
		btnNumPlanets.Text = MaxPlanets
		btnNumPlanets.Surface.DrawData( GuiState.Idle ).Image=btn200x40
				
		btnAddPlanets = New GuiButton
		btnAddPlanets.Layer = layer
		btnAddPlanets.Location = New Vec2f(SCREEN_WIDTH/2 + 110, 290)
		btnAddPlanets.Width = 40
		btnAddPlanets.Height = 40
		btnAddPlanets.Handle = New Vec2f(0,0)		
		btnAddPlanets.Font = arial24
		btnAddPlanets.Text = "+"
		btnAddPlanets.Surface.PatchData=New Int[](8)
		btnAddPlanets.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnAddPlanets.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnAddPlanets.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnAddPlanets.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnAddPlanets.Label.DrawData( GuiState.Down ).Scale=btnAddPlanets.Surface.DrawData( GuiState.Down ).Scale
		
		btnSubTurn = New GuiButton
		btnSubTurn.Layer = layer
		btnSubTurn.Location = New Vec2f(SCREEN_WIDTH/2 - 150, 440)
		btnSubTurn.Width = 40
		btnSubTurn.Height = 40
		btnSubTurn.Handle = New Vec2f(0,0)		
		btnSubTurn.Font = arial24
		btnSubTurn.Text = "-"
		btnSubTurn.Surface.PatchData=New Int[](8)
		btnSubTurn.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnSubTurn.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnSubTurn.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnSubTurn.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnSubTurn.Label.DrawData( GuiState.Down ).Scale=btnSubTurn.Surface.DrawData( GuiState.Down ).Scale	

		btnTurns = New GuiButton
		btnTurns.Layer = layer				
		btnTurns.Location = New Vec2f(SCREEN_WIDTH/2 - 100, 440)
		btnTurns.Width = 200
		btnTurns.Height = 40
		btnTurns.Handle = New Vec2f(0,0)
		btnTurns.Font = arial24
		btnTurns.Text = MaxTurns
		btnTurns.Surface.DrawData( GuiState.Idle ).Image=btn200x40

		btnAddTurn = New GuiButton
		btnAddTurn.Layer = layer
		btnAddTurn.Location = New Vec2f(SCREEN_WIDTH/2 + 110, 440)
		btnAddTurn.Width = 40
		btnAddTurn.Height = 40
		btnAddTurn.Handle = New Vec2f(0,0)		
		btnAddTurn.Font = arial24
		btnAddTurn.Text = "+"
		btnAddTurn.Surface.PatchData=New Int[](8)
		btnAddTurn.Surface.DrawData( GuiState.Idle ).Image=btn40x40		
		btnAddTurn.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnAddTurn.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnAddTurn.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnAddTurn.Label.DrawData( GuiState.Down ).Scale=btnAddMin.Surface.DrawData( GuiState.Down ).Scale	
		
		btnGenerate = New GuiButton
		btnGenerate.Layer = layer
		btnGenerate.Location = New Vec2f(SCREEN_WIDTH/2 - 150, 520)
		btnGenerate.Width = 300
		btnGenerate.Height = 40
		btnGenerate.Handle = New Vec2f(0,0)		
		btnGenerate.Font = arial24
		btnGenerate.Text = "Generate Map"
		btnGenerate.Surface.PatchData=New Int[](8)
		btnGenerate.Surface.DrawData( GuiState.Idle ).Image=btn300x40		
		btnGenerate.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnGenerate.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnGenerate.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnGenerate.Label.DrawData( GuiState.Down ).Scale=btnGenerate.Surface.DrawData( GuiState.Down ).Scale	

		btnCancel = New GuiButton
		btnCancel.Layer = layer
		btnCancel.Location = New Vec2f(SCREEN_WIDTH/2 - 150, 830)
		btnCancel.Width = 100
		btnCancel.Height = 40
		btnCancel.Handle = New Vec2f(0,0)		
		btnCancel.Font = arial24
		btnCancel.Text = "Cancel"
		btnCancel.Surface.PatchData=New Int[](8)
		btnCancel.Surface.DrawData( GuiState.Idle ).Image=btn100x40		
		btnCancel.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnCancel.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnCancel.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnCancel.Label.DrawData( GuiState.Down ).Scale=btnCancel.Surface.DrawData( GuiState.Down ).Scale	

		btnStart = New GuiButton
		btnStart.Layer = layer
		btnStart.Location = New Vec2f(SCREEN_WIDTH/2 + 50, 830)
		btnStart.Width = 100
		btnStart.Height = 40
		btnStart.Handle = New Vec2f(0,0)		
		btnStart.Font = arial24
		btnStart.Text = "Start"
		btnStart.Surface.PatchData=New Int[](8)
		btnStart.Surface.DrawData( GuiState.Idle ).Image=btn100x40		
		btnStart.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnStart.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnStart.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnStart.Label.DrawData( GuiState.Down ).Scale=btnStart.Surface.DrawData( GuiState.Down ).Scale	
	End Method
End Class 

Class Game Extends Screen
	Field layer:GuiLayer

	Field btnEndTurn:GuiButton = New GuiButton
	Field btnShowPlanets:GuiButton = New GuiButton
	Field btnShowFleets:GuiButton = New GuiButton

	Field Selected1:Planet = New Planet
	Field Selected2:Planet = New Planet
	Field p1sel:Bool 
	Field p2sel:Bool 
	Field p1id:Int 
	Field p2id:Int
		
	Method RunOnce() Override
		SetupGUI()
	End

	Method OnKeyEvent( event:KeyEvent ) Override
	End

	Method OnMouseEvent( event:MouseEvent ) Override
	End

	Method OnStart() Override
		
	End

	Method OnStop() Override
		
	End

	Method OnRender( canvas:Canvas ) Override
		Local RightClick:Bool = Mouse.ButtonReleased(MouseButton.Right)
		Local LeftClick:Bool = Mouse.ButtonReleased(MouseButton.Left)
		
		For Local p:Planet = Eachin GameMap.Planets
			p.RenderSprite(canvas)					

			If p1sel And p1id = p.ID Then 
				canvas.DrawImage(slct, p.X - 8, p.Y - 8)
			Endif	
			
			If p1sel And Not p2sel And p1id = p.ID Then 
				canvas.DrawLine(p.X, p.Y, Mouse.X, Mouse.Y)				
			Endif
			
			If p2sel And p2id = p.ID Then 
				canvas.DrawImage(slct, p.X - 8, p.Y - 8)				
			Endif
			
			If p1sel And p2sel Then 
				canvas.DrawLine(Selected1.X, Selected1.Y, Selected2.X, Selected2.Y)				
			Endif
		Next
		
		layer.Update()
		layer.Draw(canvas)		
	End

	Method OnUpdate() Override
		Local RightClick:Bool = Mouse.ButtonReleased(MouseButton.Right)
		Local LeftClick:Bool = Mouse.ButtonReleased(MouseButton.Left)
		Local EscKey:Bool = Keyboard.KeyReleased(Key.Escape)
		Local AKey:Bool = Keyboard.KeyReleased(Key.A)
		Local EKey:Bool = Keyboard.KeyReleased(Key.E)

		For Local p:Planet = Eachin GameMap.Planets
			If LeftClick And Not p1sel Then 'set the variables for first selected planet
				If Mouse.X >= p.X-8 And Mouse.X <= p.X+8 And Mouse.Y >= p.Y-8 And Mouse.Y <= p.Y+8 And p.Owner = CurrentPlayer Then 				
					p1sel = True 
					p1id = p.ID
					Selected1 = p
					'KillMapGui()
				Endif
			Elseif LeftClick And p1sel And Not p2sel Then 
				If Mouse.X >= p.X-8 And Mouse.X <= p.X+8 And Mouse.Y >= p.Y-8 And Mouse.Y <= p.Y+8 Then 
					If p1id = p.ID Then 'we can't select the same planet so kill the transfer
						p1id = 0
						p1sel = False
						Selected1 = Null
					Else												
						p2sel = True 
						p2id = p.ID
						Selected2 = p
						'ShowShipSel = True
						'KillMapGui()
						'If SendGuiCreated Then 
						'	EnableSendGUI()
						'Else
						'	SetupSendGUI(Selected1.Ships)
						'Endif
					Endif
				Endif		
			Endif
	
'			If RightClick And (Not ShowInfo Or Not ShowDenied) Then 
'				If Mouse.X >= p.X-8 And Mouse.X <= p.X+8 And Mouse.Y >= p.Y-8 And Mouse.Y <= p.Y+8 Then 
'					If p.Owner = CurrentPlayer Then
'						ShowInfo = True			
'						InfoPlanet = p
'						RightClick = False
'					Else
'						InfoPlanet = p
'						ShowDenied = True
'						RightClick = False
'					Endif
'				Endif
'			Endif			
		Next		
	End	
	
	Method SetupGUI()
		layer = New GuiLayer(ScreenManager)
		
		btnShowPlanets = New GuiButton
		btnShowPlanets.Layer = layer
		btnShowPlanets.Location = New Vec2f(10, SCREEN_HEIGHT - 41)
		btnShowPlanets.Width = 300
		btnShowPlanets.Height = 40
		btnShowPlanets.Handle = New Vec2f(0,0)		
		btnShowPlanets.Font = arial24
		btnShowPlanets.Text = "Show Planets"
		btnShowPlanets.Surface.PatchData=New Int[](8)
		btnShowPlanets.Surface.DrawData( GuiState.Idle ).Image=btn300x40		
		btnShowPlanets.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnShowPlanets.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnShowPlanets.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnShowPlanets.Label.DrawData( GuiState.Down ).Scale=btnShowPlanets.Surface.DrawData( GuiState.Down ).Scale

		btnShowFleets = New GuiButton
		btnShowFleets.Layer = layer
		btnShowFleets.Location = New Vec2f(320, SCREEN_HEIGHT - 41)
		btnShowFleets.Width = 300
		btnShowFleets.Height = 40
		btnShowFleets.Handle = New Vec2f(0,0)		
		btnShowFleets.Font = arial24
		btnShowFleets.Text = "Show Fleets"
		btnShowFleets.Surface.PatchData=New Int[](8)
		btnShowFleets.Surface.DrawData( GuiState.Idle ).Image=btn300x40		
		btnShowFleets.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnShowFleets.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnShowFleets.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnShowFleets.Label.DrawData( GuiState.Down ).Scale=btnShowFleets.Surface.DrawData( GuiState.Down ).Scale
					
		btnEndTurn = New GuiButton
		btnEndTurn.Layer = layer
		btnEndTurn.Location = New Vec2f(SCREEN_WIDTH - 310, SCREEN_HEIGHT - 41)
		btnEndTurn.Width = 300
		btnEndTurn.Height = 40
		btnEndTurn.Handle = New Vec2f(0,0)		
		btnEndTurn.Font = arial24
		btnEndTurn.Text = "End Turn"
		btnEndTurn.Surface.PatchData=New Int[](8)
		btnEndTurn.Surface.DrawData( GuiState.Idle ).Image=btn300x40		
		btnEndTurn.Surface.DrawData( GuiState.Idle ).Color=New Color( .7,.7,.7,1 )
		btnEndTurn.Surface.DrawData( GuiState.Down ).Scale=New Vec2f( .98,.98 )
		btnEndTurn.Label.DrawData( GuiState.Idle ).Color=New Color( .9,.9,.9,1 )
		btnEndTurn.Label.DrawData( GuiState.Down ).Scale=btnShowFleets.Surface.DrawData( GuiState.Down ).Scale		
	End Method
End Class 

Class SendFleet Extends Screen
	
End Class 

Class Combat Extends Screen
	
End Class 

Class Reinforcements Extends Screen
	
End Class 

Class Fleets Extends Screen
	
End Class 

Class Planets Extends Screen
	
End Class 

Class GameOver Extends Screen
	
End Class 





Enum Direction
	Forward
	Back
End Enum

Class Sprite
	Private
		Field x:Int
		Field y:Int
		Field animated:Bool
		Field animsheet:Image
		Field frames:Image[] = New Image[5]
		Field img:Image
		Field framecount:Int
		Field numframes:Int
		Field framewidth:Int
		Field frameheight:Int
		Field animdirection:Direction = Direction.Forward
		Field animfps:Int
		Field bounce:Bool = False
		Field animtimer:Timer
		Field mapx:Int
		Field mapy:Int
		Field rotation:Float = 0.0
		Field speed:Int
		Field animcount:Int
		Field destination:Vec2<Int>
		Field animcountdown:Int

	Public	
	Property X:Int()	
		Return x
	Setter (t:Int)
		x = t
	End Property 
	
	Property Y:Int()
		Return y
	Setter (t:Int)
		y = t
	End Property	
	
	Property MapX:Int()	
		Return mapx
	Setter (t:Int)
		mapx = t
	End Property 
	
	Property MapY:Int()
		Return mapy
	Setter (t:Int)
		mapy = t
	End Property	

	Property Animated:Bool()
		Return animated
	Setter (t:Bool)
		animated = t
	End Property
	
	Property AnimSheet:Image()
		Return animsheet
	Setter (t:Image)
		animsheet = t
	End Property

	Property FrameWidth:Int()
		Return framewidth
	Setter (t:Int)
		framewidth = t
	End Property 
	
	Property FrameHeight:Int()
		Return frameheight
	Setter (t:Int)
		frameheight = t
	End Property

	Property SpriteImage:Image()
		Return img
	Setter (t:Image)
		img = t
		img.Handle = New Vec2f(0.5, 0.5)
	End Property

	Property AnimDirection:Direction()
		Return animdirection
	Setter (t:Direction)
		animdirection = t
	End Property 

	Property AnimFPS:Int()
		Return animfps
	Setter (t:Int)
		animfps = t
		animtimer = New Timer(t, Tick)
		animtimer.Suspended = True
	End Property 
	
	Property Bounce:Bool()
		Return bounce
	Setter (t:Bool)
		bounce = t
	End Property 

	Property Frames:Int()
		Return numframes
	Setter (t:Int)
		numframes = t
		frames = frames.Resize(t)
	End Property		

	Property Rotation:Float()
		Return rotation
	Setter (t:Float)
		rotation = t		
	End Property
	
	Property Speed:Int()
		Return speed		
	Setter (t:Int)
		speed = t
	End Property 	

	Property AnimCount:Int()
		Return animcount
	Setter (t:Int)
		animcount = t
	End Property		

	Property Destination:Vec2<Int>()
		Return destination
	Setter (t:Vec2<Int>)
		destination = t
	End Property

	Method Update() Abstract
	Method RenderSprite(canvas:Canvas) Abstract
	Method Tick() Abstract
	
	Method GrabSprites()
		For Local t:Int = 0 To numframes - 1
			frames[t] = New Image(animsheet, t * framewidth, 0, framewidth, frameheight)
			frames[t].Handle = New Vec2f(0.5, 0.5)
		Next		
	End Method
	
	Method BeginAnimation() 
		If animtimer Then
			animtimer.Suspended = False
		Endif
		
		If animcount > 0 Then 
			animcountdown = animcount
		Endif
	End Method	

	Method EndAnimation()
		If animtimer Then
			animtimer.Suspended = True		
		Endif
		
		If animcount > 0 Then 
			animcountdown = 0
		Endif
	End Method
End Class 

Class Planet Extends Sprite
	Private
		Field production:Int
		Field ships:Int
		Field defenses:Int
		Field owner:Int
		Field ownercolor:Color
		Field name:String
		Field id:Int
		Field clicked:Bool 
		
	Public
	Property Owner:Int()
		Return owner
	Setter (t:Int)
		owner = t
	End Property	
	
	Property ID:Int()
		Return id
	Setter (t:Int)
		id = t
	End Property
		
	Property Production:Int()
		Return production
	Setter (t:Int)
		production = t
	End Property

	Property Ships:Int()
		Return ships
	Setter (t:Int)
		ships = t
	End Property

	Property Defenses:Int()
		Return defenses
	Setter (t:Int)
		defenses = t
	End Property 
	
	Property Name:String()
		Return name
	Setter (t:String)
		name = t
	End Property 

	Property Clicked:Bool()
		Return clicked
		If clicked = True clicked = False
	Setter (t:Bool)
		clicked = t
	End Property
	
	Property OwnerColor:Color()
		Return ownercolor
	Setter (t:Color)
		ownercolor = t
	End Property
	
	Method New()
		name = "Planet " + Rnd(1000,9999)
		X = 0
		Y = 0
		production = 10
		owner = 0		
	End Method
	
	Method New(pname:String, x:Int, y:Int, prod:Int, own:Int)
		name = pname
		X = x
		Y = y
		production = prod
		owner = own		
	End Method
	
	Method Tick() Override
		If bounce Then
			If animdirection = Direction.Forward Then 
				framecount += 1
			Else
				framecount -= 1
			Endif
		
			If framecount > numframes - 1 Then 
				framecount = numframes - 2
				animdirection = Direction.Back
			Endif
		
			If framecount < 0 Then 
				framecount = 1
				animdirection = Direction.Forward
			Endif
		Else
			framecount += 1
			If framecount > numframes -1 Then 
				framecount = 0
			Endif
		Endif		
		
		If animcount > 0 And animcountdown > 0 And framecount = 0 Then 
			animcountdown -= 1			
			
			If animcountdown = 0 Then 
				EndAnimation()				
			Endif
		Endif
	End Method 
	
	Method Update() Override

	End Method 
	
	Method RenderSprite(canvas:Canvas) Override
		Local tmpfont:Font = canvas.Font
		Local tmpcolor:Color = canvas.Color
		If animated Then
			canvas.Color = OwnerColor
			canvas.DrawImage(frames[framecount], x, y, Deg2Rad(rotation))
			If CurrentPlayer = owner Then 'And Mouse.X >= x - (frames[framecount].Width/2) And Mouse.X <= x + (frames[framecount].Width/2) And Mouse.Y >= y - (frames[framecount].Height/2) And Mouse.Y <= y + (frames[framecount].Height/2) Then
				canvas.Font = arial12
				canvas.DrawText(Name, x, y+16, 0.5, 0)
			Endif
		Else
			canvas.Color = OwnerColor
			canvas.DrawImage(img, x, y, Deg2Rad(rotation))			
			If CurrentPlayer = owner Then 'And Mouse.X >= x - (img.Width/2) And Mouse.X <= x + (img.Width/2) And Mouse.Y >= y - (img.Height/2) And Mouse.Y <= y + (img.Height/2) Then
				canvas.Font = arial12
				canvas.DrawText(Name, x, y+16, 0.5, 0)
			Endif
		Endif
		canvas.Font = tmpfont
		canvas.Color = tmpcolor
	End Method 
	
End Class

Class TheGameMap 
	Private
	Global themap:Int[,] = New Int[480,270]

	Global spritegridwidth:Int 
	Global spritegridheight:Int 
	Global totalwidth:Int 
	Global totalheight:Int 
	Global spriteindentx:Int 
	Global spriteindenty:Int 	

	Public 	
	Field MinProduction:Int
	Field MaxProduction:Int
	Field MaxTurns:Int
	
	Global Planets:Stack<Planet> = New Stack<Planet>

	Method GenerateMap(w:Int, h:Int, grid:Int, buffer:Int, spritewid:Int, spriteht:Int, num:Int)
		spritegridwidth = spritewid / grid 'This and spritegridheight helps us figure total width + buffer
		spritegridheight = spriteht / grid
		totalwidth = spritegridwidth + buffer 'buffer needs to be evenly divisible by 2 as well
		totalheight = spritegridheight + buffer
		spriteindentx = buffer / 2
		spriteindenty = buffer / 2
		
		planetnames = New Stack<String>
		
		For Local t:Int = 0 To 99
			planetnames.Add(pnames[t])			
		Next
		
		Planets.Clear()
		For Local x:Int = 0 To 479
			For Local y:Int = 0 To 269
				themap[x,y] = 0
			Next
		Next
		
		Local count:Int = 0
			
		SeedRnd(Millisecs())

		While count < num
			Local tmpx:Int = Rnd(0, w - buffer)
			Local tmpy:Int = Rnd(0, h - buffer)
				
			If CheckMap(tmpx, tmpy) Then 
				Continue
			Endif
						
			'otherwise we can fill the buffer area with -1 and then drop in the planet as well
			For Local tx:Int = tmpx To tmpx + totalwidth - 1
				For Local ty:Int = tmpy To tmpy + totalheight - 1
					themap[tx,ty] = -1
				Next
			Next			
			themap[tmpx + spriteindentx, tmpy + spriteindenty] = count 
	
			Local tmpplanet:Planet = New Planet("Lave", 50, 50, 20, 1)
			
			tmpplanet.ID = count
			Local tmpidx:Int = Rnd(0, planetnames.Length-1)
			tmpplanet.Name = planetnames[tmpidx]
	        planetnames.Remove(tmpplanet.Name)		
			tmpplanet.MapX = tmpx+spriteindentx
			tmpplanet.MapY = tmpy+spriteindenty
			tmpplanet.X = tmpplanet.MapX * grid
			tmpplanet.Y = tmpplanet.MapY * grid
			tmpplanet.Animated = True
			tmpplanet.AnimSheet = staranim
			tmpplanet.Frames = 5
			tmpplanet.AnimFPS = Rnd(10,30)
			tmpplanet.FrameWidth = 16
			tmpplanet.FrameHeight = 16
			tmpplanet.Bounce = True
			tmpplanet.SpriteImage = star
            tmpplanet.Production = Rnd(MinProduction, MaxProduction)
			tmpplanet.Ships = Rnd(0, tmpplanet.Production * 5)
			tmpplanet.OwnerColor = Color.White
			tmpplanet.Owner = 0

			If count = 1 Then 
				tmpplanet.OwnerColor = Color.Red				
				tmpplanet.Owner = 1
				tmpplanet.Production = MinProduction + ((MaxProduction - MinProduction) / 1.9)
				tmpplanet.Ships = Rnd(tmpplanet.Production * 2, tmpplanet.Production * 7.5) + 100
			Endif

			tmpplanet.GrabSprites()
	
			tmpplanet.BeginAnimation()
	
			Planets.Add(tmpplanet)
	
			count += 1
		Wend  
	End Method	
	
	Method CheckMap:Bool(tmpx:Int, tmpy:Int)
		Local result:Bool = False
		For Local tx:Int = tmpx To tmpx + totalwidth - 1
			For Local ty:Int = tmpy To tmpy + totalheight - 1
				If themap[tx,ty] <> 0 Then 
					result = True
				Endif
			Next
		Next			
		Return result				
	End Method	
End Class

Class Fleet 
	Field Destination:Planet
	Field Source:Planet
	Field Ships:Int
	Field Turns:Int 'Turns until it reaches destination	
	Field Done:Bool = False
End Class

Function Rad2Deg:Double(x:Double)
	Const DegreeScalar := (180.0 / Pi)	
	Return (x * DegreeScalar)
End
 
Function Deg2Rad:Double(x:Double)
	Const RadianScalar := (Pi / 180.0)
	Return (x * RadianScalar)
End
	
Function Cosd:Double(x:Double)
	Return Cos(Rad2Deg(x))
End
 
Function Sind:Double(x:Double)
	Return Sin(Rad2Deg(x))
End
