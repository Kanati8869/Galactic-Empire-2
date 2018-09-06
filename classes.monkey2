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
		Print "Menu started"
		SetTimer(60)
	End

	Method OnStop() Override
		Print "Menu stopped"
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
			Print""
			game.Set()
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
