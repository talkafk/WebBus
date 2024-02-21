@tool
extends EditorExportPlugin
class_name  HTMLExportPlugin

const JS_YANDEX_FILE = "yandex_sdk.js"
const JS_YANDEX_SDK_REF = "https://yandex.ru/games/sdk/v2"
const JS_CRAZY_SDK_REF = "https://sdk.crazygames.com/crazygames-sdk-v2.js"

var plugin_path: String = get_script().resource_path.get_base_dir()
var is_yandex := false
var is_crazy := false
var export_path := ""

func _get_name() -> String:
	return "YandexCrazySDK"


func _export_begin(features: PackedStringArray , is_debug: bool, path: String, flags: int) -> void:
	if features.has("yandexgames"):
		is_yandex = true
		export_path = path
	elif features.has("crazygames"):
		is_crazy = true
		export_path = path


func _export_end() -> void:
	if is_yandex:
		var file := FileAccess.open(export_path, FileAccess.READ)
		var html := file.get_as_text()
		file.close()
		var pos = html.find('</head>')
		
		html = html.insert(pos, 
				'<script src="' + JS_YANDEX_SDK_REF + '"></script>\n' +
				'<script src="' + JS_YANDEX_FILE + '"></script>\n')
		DirAccess.open(".")\
				.copy(plugin_path + '/' + JS_YANDEX_FILE,\
				export_path.get_base_dir() + '/' + JS_YANDEX_FILE)
		
		file = FileAccess.open(export_path, FileAccess.WRITE)
		file.store_string(html)
		file.close()
		zip_export("yandex_export.zip")
	elif is_crazy:
		var file := FileAccess.open(export_path, FileAccess.READ)
		var html := file.get_as_text()
		file.close()
		var pos = html.find('</head>')
		
		html = html.insert(pos, 
				'<script src="' + JS_CRAZY_SDK_REF + '"></script>\n')
		file = FileAccess.open(export_path, FileAccess.WRITE)
		file.store_string(html)
		file.close()
	is_yandex = false
	is_crazy = false
	
	
func zip_export(name_file:String):
	var writer := ZIPPacker.new()
	var archive_path :String = export_path.get_base_dir() + "/" + name_file
	var err := writer.open(archive_path)
	if err != OK:
		push_error("Error open zip file")
	var all_files = DirAccess.open(export_path.get_base_dir()).get_files()
	for f in all_files:
		var file_path = export_path.get_base_dir() + '/' + f
		if file_path == archive_path:
			continue
		var file_object = FileAccess.open(file_path, FileAccess.READ)
		var file_content = file_object.get_file_as_bytes(file_path)
		file_object.close()
		writer.start_file(f)
		writer.write_file(file_content)
