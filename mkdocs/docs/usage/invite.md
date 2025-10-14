
## Invite Links

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green)   |
| Yandex Games      | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Poki              | ![✔️](https://img.shields.io/badge/Supported-green)   |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |

Create invite links with your parameters:

```gdscript
var result = await WebBus.invite_link(params)
```
`params` : **Dictionary** type

`result` : **Dictionary** type, invite link on this platform

Get parameters from link:

```gdscript
var value = await WebBus.get_invite_param(params)
```
`key` : **String** type

`result` : **Dictionary** type, invite link on this platform

## Invite Button

| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![✔️](https://img.shields.io/badge/Supported-green)   |
| Yandex Games      | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![❌](https://img.shields.io/badge/Not_Supported-red) |

Show invite button:

```gdscript
WebBus.show_invite_button(params)
```
`params` : **Dictionary** type

Hide invite button:

```gdscript
WebBus.hide_invite_button(params)
```