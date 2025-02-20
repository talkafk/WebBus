# WebBus
It's a plugin for the Godot engine. Use one plugin for several web platform SDKs.

This version is for Godot 4.x.
## Contents

- [Supported platforms](#supported-platforms)
- [Installation](#installation)
- [Usage](#usage)
  - [General](#general)
	  - [Advertisement](#advertisement)
    - [Game](#game)
    - [Ready](#ready)
    - [Other](#other)
    - [Leaderboards](#leaderboards)
    - [Payments](#payments)
    - [Server time](#server-time)
    - [Game rating](#game-rating)
    - [Desktop shortcut](#desktop-shortcut)
  - [Main Screen Menu](#main-screen-menu)


## Supported platforms
- Crazy games
- Yandex games
- Poki

## Installation

1. Download the plugin as a ZIP archive.
2. Extract the ZIP archive and move the `addons/` folder it contains into your project folder.
3. Enable the plugin in **Project > Project Settings > Plugins**.


## Usage

You can explore the demo scene for a better understanding of how to use the plugin.

### General

#### Advertisement

Calling full-screen advertisement:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |


```gdscript
WebBus.show_ad()
```
Calling rewarded advertisement:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |


```gdscript
WebBus.show_rewarded_ad()
```

For full-screen and rewarded advertisements, there are 4 callback signals:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |


```gdscript
signal reward_added
signal ad_closed
signal ad_error
signal ad_started
```

Calling banner advertisement:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |


```gdscript
WebBus.show_banner()
```

Close banner advertisement:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
WebBus.hide_banner()
```
>For Crazy Games banner you can set the size and position in the [Main Screen Menu](#main-screen-menu)

#### Game

The `start_gameplay()` function has to be called whenever the player starts playing or resumes playing after a break.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |

```gdscript
WebBus.start_gameplay()
```

The `stop_gameplay()` function has to be called on every game break don't forget to call `start_gameplay(` when the gameplay resumes.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |

```gdscript
WebBus.stop_gameplay()
```


The `happytime()` method can be called on various player achievements.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |


```gdscript
WebBus.happytime()
```

The `start_loading()` function has to be called whenever you start loading your game.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
WebBus.crazy_start_loading()
```


#### Ready

Call `ready()` function when the game ready for game. For Crazy Games, this is equivalent to `sdkGameLoadingStop()`. For Poki, this is equivalent to `gameLoadingFinished()`

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |

```gdscript
WebBus.ready()
```

#### Other

Getting name of platform:

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green) |

```gdscript

var platform_name = WebBus.get_platform()
# return String: "yandex", "crazy_games",  "poki"

```

Getting type of device:

The function return `String`, possible values: "desktop", "tablet", "mobile".

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
var device_type = WebBus.get_type_device()
```

Getting language:

The function return 2 letter is language code.

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |

```gdscript
var language = WebBus.get_language()
```

#### Leaderboards

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |

Features exclusive to Yandex games.

Get leaderboard description:
```gdscript
WebBus.leaderboard_info_recieved.connect(getting_leaderboard_info)

WebBus.get_leaderboard_info(name_leaderboard)

func getting_leaderboard_info(info):
	print(info)

```

`name_leaderboard` : **String** type

`info` : **Dictionary** type

Get leaderboard player entry:
```gdscript
WebBus.leaderboard_player_entry_recieved.connect(getting_leaderboard_player_entry)

WebBus.get_leaderboard_player_entry(name_leaderboard)

func getting_leaderboard_player_entry(info):
	print(info.score)

```

`name_leaderboard` : **String** type

`info` : **Dictionary** type

Get leaderboard entries:
```gdscript
WebBus.leaderboard_entries_recieved.connect(getting_leaderboard_entries)

WebBus.get_leaderboard_entries(name_leaderboard, include_user=true, quantity_around=5, quantity_top=5)

func getting_leaderboard_entries(info):
	print(info.userRank)

```

`name_leaderboard` : **String** type

`include_user` : **bool** type, optional parameter

`quantity_around` : **int** type, optional parameter

`quantity_top` : **int** type, optional parameter

`info` : **Dictionary** type

Save score in leaderboard:
```gdscript
WebBus.set_leaderboard_score(name_leaderboard, score, extra_data)
```

`name_leaderboard` : **String** type

`score` : **int** type

`extra_data` : optional parameter, **String** type

#### Payments

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |


Init yandex payments

```gdsript
WebBus.init_payments(signed)
```

`signed`: optional parameter, **bool** type

Make purchase

```gdscript
var success = await WebBus.purchase(product_id, developer_payload)
```

`product_id`: **String** type

`developer_payload`: optional parameter, **String** type

Get player's purchase list


```gdscript
var purchase_list = await WebBus.get_purchases()
```

Get product list

```gdscript
var product_list = await WebBus.get_catalog()
```
#### Server time

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |


Get server time

```gdscript
var time:int = WebBus.get_server_time() # Example: 1720613073778
```

#### Game Rating

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |


Check if the player can provide feedback:

```gdscript

var feedback_info = await WebBus.can_rewiew()
print(feedback_info.value) # bool

```

Request feedback from the player:

```gdscript

var feedback_request = await WebBus.request_review()
print(feedback_request.feedback_sent) # bool

```
#### Desktop shortcut

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |

Check if the player can show a prompt:

```gdscript

var prompt = await WebBus.can_show_prompt()
print(prompt.can_show) # true or false

```

Show a prompt to the player:

```gdscript
var result = await WebBus.show_prompt()
print(result.outcome) # "accepted"
```

### Main Screen Menu

In the main screen menu you can set your settings.

>You can enable automatic build archiving, but make sure the export folder does not contain any extraneous files.

![alt text](image.png)
