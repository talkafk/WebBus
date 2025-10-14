## Start Loading

The `start_loading()` function has to be called whenever you start loading your game.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
WebBus.start_loading()
```

## Ready

Call `ready()` when the game is fully loaded and ready to play. 

> **Note:** For Crazy Games, calling `ready()` is equivalent to `sdkGameLoadingStop()`. For Poki, this is equivalent to `gameLoadingFinished()`


| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
WebBus.ready()
```

## Gameplay

The `start_gameplay()` function has to be called whenever the player starts playing or resumes playing after a break.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
WebBus.start_gameplay()
```

The `stop_gameplay()` function has to be called on every game break, don't forget to call `start_gameplay()` when the gameplay resumes.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
WebBus.stop_gameplay()
```
## Happytime

The `happytime()` method can be called on various player achievements.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |


```gdscript
WebBus.happytime()
```