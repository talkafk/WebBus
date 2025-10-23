
| Platform          | Supported                                             |
|-------------------|-------------------------------------------------------| 
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green)   |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green)   |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green)   |

`user_info` dictionary contains player's username and avatar link

```gdscript
print(WebBus.user_info)
# {"player_name": "NameOfPlayer", "avatar": "https://link/to/avatar.png"}

var name = WebBus.user_info.player_name
var avatar_link = WebBus.user_info.avatar
```