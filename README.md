# WebSDKPlugin
It's plugin fo Godot engine. Use one plugin for several web platform SDK.

## Installation

1. Download the plugin as a ZIP archive.
2. Extract the ZIP archive and move the `addons/` folder it contains into your project folder.
3. Enable the plugin in **Project > Project Settings > Plugins**
4. Create web export presets.
5. Add custom feature `yandexgames` or `crazygames` in web export preset.
    
    >Add only one custom feature in one export presets 

![img.png](img.png)

## Usage

Calling fullscreen advertisement:
```
WebSDK.show_ad()
```
Calling rewarded advertisement:
```
WebSDK.show_rewarded_ad()
```
