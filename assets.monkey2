#Import "Assets/"

Global sprites:Image = Image.Load("asset::sprites.png")
Global starfield:Image = Image.Load("asset::starfield.png")
Global starfielddark:Image = Image.Load("asset::starfielddark.png")
Global staranim:Image = Image.Load("asset::staranim.png")
Global arial12:Font = Font.Load("asset::arial.ttf", 12)
Global arial16:Font = Font.Load("asset::arial.ttf", 16)
Global arial24:Font = Font.Load("asset::arial.ttf", 24)
Global arialblk48:Font = Font.Load("asset::ariblk.ttf", 48)
Global arialblk72:Font = Font.Load("asset::ariblk.ttf", 72)
Global btn300x40:Image = Image.Load("asset::button300x40.png")
Global btn200x40:Image = Image.Load("asset::button200x40.png")
Global btn40x40:Image = Image.Load("asset::button40x40.png")
Global btn100x40:Image = Image.Load("asset::button100x40.png")
Global panel250x400:Image = Image.Load("asset::panel250x400.png")
Global sliderknob:Image = Image.Load("asset::sliderknob.png")
Global panel400x250:Image = Image.Load("asset::panel400x250.png")
Global panel400x1070:Image = Image.Load("asset::panel400x1070.png")
Global star:Image
Global ship:Image
Global slct:Image

Global themap:Int[,] = New Int[480,270]

Global planets:Stack<Planet> = New Stack<Planet>

Global pnames:String[] = New String[100]("Sol", "Bernthal", "Grimes", "Lave", "Barclay", "Veris", "Darmok", "Jilaad", "Tanagra", "Ceti Alpha V", 
                                        "Centauri", "Borgus", "Danaal", "Madrigal", "Bob", "Beetlejuice", "Gusfring", "Awaree", "Tellus", "Jelluk",
                                        "Clapton", "Masek", "Dundee", "Logan", "Thanos", "Desaad", "Vermin", "Tarrasque", "Nimoy", "Horizon",
                                        "Katya", "Hayes", "Quinto", "Zachun", "Risa", "Orion", "Antares", "Beezus", "Kolchak", "Satoshi",
                                        "Loki", "Gamora", "Nabu", "Koriand'r", "Bonham", "Page", "Plant", "Pentarus", "Kalel", "Maga",
                                        "Zaphod", "Nophet", "Brell", "Danzig", "Bevis", "Furya", "Corovan", "Ursa Luna", "Butcher Bay", "Taurus",
                                        "Lupus", "Tangier", "Cassinia", "Chabyx", "TR1-46", "Templar", "Jalta", "Porius", "Klien", "Kirby",
                                        "Byrne", "Romita", "Kubert", "Rossi", "Marquez", "Payton", "Hyux IV", "Xander", "Guswouwei", "Oswoania",
                                        "Fosheilia", "Jothoutania", "Ceslorix", "Xodrilles", "Qiyzuno", "Leorus", "Smaceter", "Slusaturn", "Spion 5D", "Scion B8F",
                                        "Fiero", "Debliulia", "Mobliyvis", "Qeskao", "Taicarro", "Watov", "Uipra", "Gluonov", "Crapus 127", "Slade")

Global planetnames:Stack<String> 

Function GetSprites()
	star = New Image(sprites, 0, 0, 16, 16)
	ship = New Image(sprites, 16, 0, 16, 16)
	slct = New Image(sprites, 32, 0, 16, 16)
End Function 