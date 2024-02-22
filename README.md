# WebSDKPlugin
It's a plugin for the Godot engine. Use one plugin for several web platform SDKs.

This version is for Godot 4.

## Supported platforms:
- Crazy games
- Yandex games

## Installation

1. Download the plugin as a ZIP archive.
2. Extract the ZIP archive and move the `addons/` folder it contains into your project folder.
3. Enable the plugin in **Project > Project Settings > Plugins**.
4. Create web export presets.
5. Add the custom feature `yandexgames` or `crazygames` in the web export preset.
   >Add only one custom feature in one export preset.
6. Create an empty folder and set the **Export path** in this folder.
   > It is important that there are no extraneous files in the folder,
   > otherwise they will end up in the created zip archive.

![img.png](img.png)

## Usage

You can explore the demo scene for a better understanding of how to use the plugin.

### General

Calling full-screen advertisement:
```
WebSDK.show_ad()
```
Calling rewarded advertisement:
```
WebSDK.show_rewarded_ad()
```

For advertisements, there are 4 callback signals:
```
signal reward_added
signal ad_closed
signal ad_error
signal ad_started
```


Getting type of device:
```
WebSDK.type_device_recieved.connect(type_device_recieved)

WebSDK.get_type_device()

func type_device_recieved(type):
	print("device_type: ", type)
```

Getting language:

```
WebSDK.language_recieved.connect(language_recieved)

WebSDK.get_language()

func language_recieved(lang):
	print("language: ", lang)
```

### Yandex
Features exclusive to Yandex games.

Save score in leaderboard:
```
WebSDK.set_yandex_leaderboard(name_leaderboard, score, extra_data)
```

`leaderboard` : **String** type

`score` : **int** type

`extra_data` : optional parameter, **String** type
