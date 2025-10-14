
| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |


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