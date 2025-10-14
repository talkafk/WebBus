
| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![✍️](https://img.shields.io/badge/In_Progress-yellow) |


## Get leaderboard description

```gdscript
WebBus.leaderboard_info_recieved.connect(getting_leaderboard_info)

WebBus.get_leaderboard_info(name_leaderboard)

func getting_leaderboard_info(info):
	print(info)

```

`name_leaderboard` : **String** type

`info` : **Dictionary** type

## Get leaderboard player entry

```gdscript
WebBus.leaderboard_player_entry_recieved.connect(getting_leaderboard_player_entry)

WebBus.get_leaderboard_player_entry(name_leaderboard)

func getting_leaderboard_player_entry(info):
	print(info.score)

```

`name_leaderboard` : **String** type

`info` : **Dictionary** type

## Get leaderboard entries

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

## Save score in leaderboard

```gdscript
WebBus.set_leaderboard_score(name_leaderboard, score, extra_data)
```

`name_leaderboard` : **String** type

`score` : **int** type

`extra_data` : optional parameter, **String** type