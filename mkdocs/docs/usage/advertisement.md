

## Fullscreen Advertisement

Calling full-screen advertisement:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green) |


```gdscript
WebBus.show_ad()
```

## Rewarded Advertisement

Calling rewarded advertisement:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green) |


```gdscript
WebBus.show_rewarded_ad()
```

For full-screen and rewarded advertisements, there are 4 callback signals:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green) |

```gdscript
WebBus.reward_added 
WebBus.ad_closed
WebBus.ad_error
WebBus.ad_started
```


### Full example

```gdscript
extends Node

func _ready():
    WebBus.ad_closed.connect(ad_closed)
    WebBus.ad_error.connect(ad_error)
    WebBus.ad_started.connect(ad_started)
    WebBus.reward_added.connect(reward_added)

    WebBus.show_rewarded_ad()


func ad_started():
    AudioServer.set_bus_mute(0, true)


func ad_closed():
    AudioServer.set_bus_mute(0, false)
    

func ad_error():
    push_warning("ad_error")
    

func reward_added():
    $Player.add_gold(10)

```
## Banner advertisement



| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green) |

Calling banner advertisement:

```gdscript
WebBus.show_banner()
```

Close banner advertisement:

```gdscript
WebBus.hide_banner()
```

!!! note
    For Crazy Games banner you can set the size and position in the Main Screen Menu