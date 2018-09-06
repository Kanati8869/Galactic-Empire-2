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
		' Game update code here!
	End

	Method RunOnce() Override
		Print "SETTING UP MENU GUI"
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
