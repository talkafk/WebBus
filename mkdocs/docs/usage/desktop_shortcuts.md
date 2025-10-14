
| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![✍️](https://img.shields.io/badge/In_Progress-yellow) |

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