#!/usr/bin/env -S godot -s
extends SceneTree

func _init():
	print("Running tests...")
	var passed = 0
	var failed = 0
	
	# Подключение тестов
	var test_files = [
		"res://tests/test_example.gd"
	]
	
	for test_file in test_files:
		var test_instance = load(test_file)
		for test_method in test_instance.get_script_method_list():
			if test_method.name.begins_with("test_"):
				var result = test_instance.call(test_method.name)
				if result == OK:
					print("✅", test_method.name, "PASSED")
					passed += 1
				else:
					print("❌", test_method.name, "FAILED")
					failed += 1
	
	print("\nRESULTS:")
	print("✅ Passed:", passed)
	print("❌ Failed:", failed)
	if failed > 0:
		quit(13)
	else:
		quit(0)
