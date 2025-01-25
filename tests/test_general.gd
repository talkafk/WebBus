# res://tests/test_example.gd
extends "res://tests/tester.gd"

static func test_working_test():
	return assert_eq(1, 1)


static func test_valid_plugin():
	var plugin := load("res://addons/WebBusPlugin/WebBus.gd")
	if plugin.can_instantiate():
		return OK
	else:
		return FAILED
