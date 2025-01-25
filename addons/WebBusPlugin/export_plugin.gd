@tool
extends EditorExportPlugin
class_name  HTMLExportPlugin

const JS_FILE = "webbus_sdk.js"

var ARCHIVE_NAME = "export.zip"

var CRAZY_BANNER_STYLE = "width: 720px; height: 90px; position: fixed; bottom:0; z-index:9999"

var plugin_path: String = get_script().resource_path.get_base_dir()
var export_path := ""
var _features: Array

var crazy_banner_w := "728px"
var crazy_banner_h := "90px"
var crazy_banner_pos := "bottom" 
var is_archive:bool

func _get_name() -> String:
	return "WebBus"


func _export_begin(features: PackedStringArray , is_debug: bool, path: String, flags: int) -> void:
	export_path = path
	_features = features


func _export_end() -> void:
	if "web" in _features:
		var file := FileAccess.open(export_path, FileAccess.READ)
		var html := file.get_as_text()
		file.close()
		var pos = html.find('</head>')
		
		html = html.insert(pos, 
				'<script src="' + JS_FILE + '"></script>\n')
		DirAccess.open(".")\
				.copy(plugin_path + '/' + JS_FILE,\
				export_path.get_base_dir() + '/' + JS_FILE)
		CRAZY_BANNER_STYLE = "width: " + str(crazy_banner_w) + "; height: " + str(crazy_banner_h) + "; position: fixed; " + crazy_banner_pos + ":0; z-index:9999"
		html = html.insert(pos,
				'<div id="responsive-banner-container" hidden="hidden" style="'
				+ CRAZY_BANNER_STYLE +'"></div>'
				)
		file = FileAccess.open(export_path, FileAccess.WRITE)
		file.store_string(html)
		file.close()
		if is_archive:
			zip_export(ARCHIVE_NAME)
	
	
	
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
