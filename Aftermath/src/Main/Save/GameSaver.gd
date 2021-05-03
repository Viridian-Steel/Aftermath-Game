extends Node

const SaveGame = preload('res://src/Main/Save/SaveGame.gd')

var SAVE_FOLDER: String = "res://debug/save"
var SAVE_NAME_TEMPLATE: String = "Save_%03d.tres"

func save(id: int):
    # Paases a saveGame Resource to every node to save data from
    # and writes it to the disj
    var save_game = SaveGame.new()
    save_game.game_version = ProjectSettings.get_setting("application/config/version")
    for node in get_tree().get_nodes_in_group('save'):
        node.save(save_game)
    
    var directory: Directory = Directory.new()
    if not directory.dir_exists(SAVE_FOLDER):
# warning-ignore:return_value_discarded
        directory.make_dir_recursive(SAVE_FOLDER)
    
    var save_path = SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
    var error: int = ResourceSaver.save(save_path, save_game)
    if error != OK:
        print("Error in writing save %s to %s" % [id, save_path])
        
func load(id: int):
    # Reads a saved game from the disk and delegates loading
    # to the individual nodes to load
    var save_file_path: String = SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
    var file: File = File.new()
    if not file.file_exists(save_file_path):
        print("Save File %s doesn't exist" % save_file_path)
        return
        
    var save_game: Resource = load(save_file_path)
    for node in get_tree().get_nodes_in_group('save'):
        node.load(save_game)
