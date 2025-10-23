
## Platform 
Getting name of platform:

The function returns a `String`. Possible values are: `yandex`, `crazy_games`, `poki`, `vk`.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green) |

```gdscript
var platform_name = WebBus.get_platform()
```
## Device type

Getting type of device:

The function returns a `String`, possible values: `desktop`, `tablet`, `mobile`.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green)    |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green)    |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red)  |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green)    |


```gdscript
var device_type = WebBus.get_type_device()
```
## Language

Getting language:

The function returns 2-letter language code.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green)    |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green)    |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red)  |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green)    |

```gdscript
var language = WebBus.get_language()
```