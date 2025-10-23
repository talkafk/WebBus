
| Platform          | Supported                                             |
|-------------------|-------------------------------------------------------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green)   |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green)   |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![✔️](https://img.shields.io/badge/Supported-green)   |

Setting data:

```gdscript
var data:Dictionary = {"Key": "Value"}
WebBus.set_data(data)

```

Getting data:

```gdscript
var result = await WebBus.get_data("Key") # One key
print(result) # {"Key": "Value"}

var result = await WebBus.get_data(["Key1", "Key2"]) # Several keys
print(result) # {"Key1": "Value1", "Key2": "Value2"}

```

!!! NOTE 
    For CrazyGames and VK, the functions set_stats() and get_stats() are identical to the functions set_data() and get_data(), respectively.


Setting stats:

```gdscript
var data:Dictionary = {"Key": 12345}
WebBus.set_stats(data)

```

Getting stats:

```gdscript
var result = await WebBus.get_stats("Key") # One key
print(result) # {"Key": 1234.5}

var result = await WebBus.get_stats(["Key1", "Key2"]) # Several keys
print(result) # {"Key1": 1234.5, "Key2": 5432.1}

```

