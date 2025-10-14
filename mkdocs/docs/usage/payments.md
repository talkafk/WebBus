
| Platform          | Supported |
|-------------------|-----------|
| Crazy Games       | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| Yandex Games      | ![✔️](https://img.shields.io/badge/Supported-green) |
| Poki              | ![❌](https://img.shields.io/badge/Not_Supported-red) |
| VK                | ![✍️](https://img.shields.io/badge/In_Progress-yellow) |


### Init payments

```gdsript
await WebBus.init_payments(signed)
```

`signed`: optional parameter, **bool** type

### Make purchase

```gdscript
var purchase:Dictionary = await WebBus.purchase(product_id, developer_payload)
```

`product_id`: **String** type

`developer_payload`: optional parameter, **String** type

### Get player's purchase list


```gdscript
var purchase_list:Array = await WebBus.get_purchases()
```

### Get product list

```gdscript
var product_list:Array = await WebBus.get_catalog()
```

### Consume purchase

```gdscript
var success:bool = await WebBus.consume_purchase(token)
```

`token`: **String** type

## Purchase example
```gdscript
await WebBus.init_payments()
var purchase:Dictionary = await WebBus.purchase("your_purchase_id")
if ! purchase.get("error", false): # Check if the purchase was successful
	player.add_gold(500)
	WebBus.consume_purchase(purchase.purchase_token)
```