Global splash:Splash
Global menu:Menu
Global settings:Settings
Global gamesetup:GameSetup
Global game:Game
Global sendfleet:SendFleet
Global combat:Combat
Global reinforcements:Reinforcements
Global fleets:Fleets
Global planets:Planets
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
		fleets = New Fleets
		planets = New Planets
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
	
	Method OnStart() Override
		
	End

	Method OnStop() Override
		
	End

	Method OnRender( canvas:Canvas ) Override
		canvas.Color = New Color(RGB * 100, RGB * 100, RGB * 100, 1)
		canvas.DrawImage(starfield, 0, 0)
		canvas.Color = Color.White

		layer.Update()
		layer.Draw(canvas)
	End

	Method OnUpdate() Override
		If Keyboard.KeyReleased(Key.Escape) Then 
			Print "Going back to menu"
			menu.Set()
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
		txtName.Text = "Playername"
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
		btnMinProduction.Text = "5"
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
		btnMaxProduction.Text = "25"
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
		btnNumPlanets.Text = "20"
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
		btnTurns.Text = "100"
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
