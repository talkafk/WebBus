
| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green) |

!!! NOTE
    This function works on any hosting, including the test server Godot.


Sometimes the built-in Godot focus tracking tools may not work under specific conditions. To avoid unwanted behavior in such cases, this plugin provides signals:
- `focused`
- `unfocused`

Example:
```gdscript
WebBus.focused.connect(func():
	get_tree().set_pause(false))
WebBus.unfocused.connect(func():
	get_tree().set_pause(true))
```