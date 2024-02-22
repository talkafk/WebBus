# WebSDKPlugin
It's a plugin fo Godot engine. Use one plugin for several web platform SDKs.

## Installation

1. Download the plugin as a ZIP archive.
2. Extract the ZIP archive and move the `addons/` folder it contains into your project folder.
3. Enable the plugin in **Project > Project Settings > Plugins**
4. Create web export presets.
5. Add the custom feature `yandexgames` or `crazygames` in the web export preset.
   >Add only one custom feature in one export preset.
6. Create an empty folder and set **Export path** in this folder.
   > It is important that there are no extraneous files in the folder,
   > otherwise they will end up in the created zip archive.

![img.png](img.png)

## Usage

You can explore the demo scene for a better understanding of how to use the plugin.

### General

Calling fullscreen advertisement:
```
WebSDK.show_ad()
```
Calling rewarded advertisement:
```
WebSDK.show_rewarded_ad()
```

Getting type of device:
```
WebSDK.type_device_recieved.connect(type_device_recieved)

WebSDK.get_type_device()

func type_device_recieved(type):
	print("device_type: ", type)
```

### Yandex
Features exclusive to Yandex games SDK.

Save score in leaderboard:
```
WebSDK.set_yandex_leaderboard(name_leaderboard, score, extra_data)
```

`leaderboard` - **String** type

`score` - **int** type

`extra_data` - optional parameter, **String** type
