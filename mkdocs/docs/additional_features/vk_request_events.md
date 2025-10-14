You can send any event supported by VK Bridge using the `WebBus.tools.VKRequest` class.  
Refer to the VK documentation for the current list of available events. 

```gdscript
var request := WebBus.tools.VKRequest.new()
request.send("VKWebAppShowNativeAds", {"ad_format": "interstitial"}, callback)

func callback(args:Dictionary) -> void:
	if args.result:
		print("success")
	else:
		print("error")
```
