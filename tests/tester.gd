extends SceneTree


static func assert_eq(first, second) -> int:
	if first == second:
		return OK
	return FAILED
