
| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![✍️](https://img.shields.io/badge/In_Progress-yellow) |

```gdscript
var succees_auth = await WebBus.open_auth_dialog()
print(succees_auth) # true/false
print(WebBus.user_info.player_name)
```


