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

Global GameYear:Int = 3000
Global CurrentPlayer:Int = 1

Global GameMap:TheGameMap = New TheGameMap
Global P1Fleets:Stack<Fleet> = New Stack<Fleet>


Function Main()
	LoadSettings()
	
	GetSprites()
	
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
End Function 

Function GetDistance:Int(P1:Planet, P2:Planet, Scale:Int)
	Local TmpDistance:Int
	Local x1:Int = P1.X
	Local y1:Int = P1.Y
	Local x2:Int = P2.X
	Local y2:Int = P2.Y
	Local xdist:Int = Abs(x1 - x2)
	Local ydist:Int = Abs(y1 - y2)

	'pythagorean theorem x^2 + y^2 = z^2
	TmpDistance = Sqrt((xdist * xdist) + (ydist * ydist)) / Scale

	Return TmpDistance		
End Function
