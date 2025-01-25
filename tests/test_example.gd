# res://tests/test_example.gd
extends "res://tests/tester.gd"

static func test_addition():
	return assert_eq(1, 2)
	
	
static func test_string_concatenation():
	var result = "Hello, " + "World!"
	return assert_eq(result, "Hello, World!")
