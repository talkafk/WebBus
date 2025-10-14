
## Installation

1. Download the plugin as a ZIP archive.
2. Extract the ZIP archive and move the `addons/` folder it contains into your project folder.
   
!!! Note   
    You can also install the plugin from the [Asset Library](https://godotengine.org/asset-library/asset/2841).

3. Enable the plugin in **Project > Project Settings > Plugins**.

## Initialization

!!! WARNING
    If you use any Webbus method in _ready() of an autoload script or the initial scene, you need to wait until the plugin is fully initialized before calling its method. See the example below.

```gdscript
var lang :String

func _ready() -> void:
	if !WebBus.is_init:
		await WebBus.inited
    # You can now safely call WebBus methods
	WebBus.ready()
	lang = WebBus.get_language()
```
## Call methods

Call any methods through the `WebBus` singleton.

```gdscript
WebBus.show_ad()
```
