#Import "<std>"
#Import "<mojo>"
#Import "<pyro-framework>"
#Import "<pyro-gui>"

#Import "assets"
#Import "classes"

Using std..
Using mojo..
Using pyro.framework..
Using pyro.gui..

Global SCREEN_WIDTH:Int = 1920
Global SCREEN_HEIGHT:Int = 1080
Global RGB:Float = 1.0 / 255.0
Global MaxPlanets:Int = 20
Global MaxProduction:Int = 40
Global MinProduction:Int = 10
Global MaxTurns:Int = 250

Global c:Config = New Config





Function Main()
	LoadSettings()
	
	New AppInstance

	New Empire("Galactic Empire v2.0", SCREEN_WIDTH, SCREEN_HEIGHT)
	
	App.Run()
End Function 

Function LoadSettings()
	c.Load("asset::settings.ini")
	SCREEN_WIDTH = Cast<Int>(c.ReadString("ResolutionX"))
	SCREEN_HEIGHT = Cast<Int>(c.ReadString("ResolutionY"))
	MaxPlanets = Cast<Int>(c.ReadString("Planets"))
	MaxProduction = Cast<Int>(c.ReadString("MaxProd"))
	MinProduction = Cast<Int>(c.ReadString("MinProd"))
	MaxTurns = Cast<Int>(c.ReadString("Turns"))
	
	Print SCREEN_WIDTH
	Print SCREEN_HEIGHT
	Print MaxPlanets
	Print MaxProduction
	Print MinProduction
	Print MaxTurns
End Function 
