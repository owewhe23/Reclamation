extends MeshInstance
var texture = ImageTexture.new()
var image = Image.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	image.load("res://2021 - Reclamation/Backdrop.jpg")
	texture.create_from_image(image)
	$Sprite.texture = texture


