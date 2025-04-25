extends Object

class_name ItemFactory

enum ITEM_CATEGORY { COMMON, SPICES, ORES }

static var _available_items : Dictionary = {
	ITEM_CATEGORY.COMMON : [
		BaseItem.ITEM_TYPE.VEGS_AND_FRUITS,
		BaseItem.ITEM_TYPE.CHEESE,
		BaseItem.ITEM_TYPE.PROTEIN,
	],
	ITEM_CATEGORY.SPICES : [
		BaseItem.ITEM_TYPE.CLOVE,
		BaseItem.ITEM_TYPE.CINNAMON,
		BaseItem.ITEM_TYPE.GINGER
	],
	ITEM_CATEGORY.ORES : [
		BaseItem.ITEM_TYPE.GOLD,
		BaseItem.ITEM_TYPE.BRONZE,
		BaseItem.ITEM_TYPE.EMERALD
	]
}

static var _item_scenes : Dictionary = {
	BaseItem.ITEM_TYPE.VEGS_AND_FRUITS : preload("res://items/common/vegs/vegetable.tscn"),
	BaseItem.ITEM_TYPE.CHEESE : preload("res://items/common/cheese/cheese.tscn"),
	BaseItem.ITEM_TYPE.PROTEIN : preload("res://items/common/animal_protein/protein.tscn")
}

static func create_random_item_from_category(category : ITEM_CATEGORY) -> BaseItem:
	var item_type = _available_items[category].pick_random()
	var item_scene : PackedScene = _item_scenes[item_type]
	var item_node = item_scene.instantiate()
	print("Created item:")
	print(item_node)
	return item_node
