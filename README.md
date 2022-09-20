Hope this package can help us to save our lottie network animation to our local Storage.

Goal of this package : 
Helping us to save animation byte data when we using Lottie Network. So, when the device did'nt connect to WIFI or Mobile Data. The Apps gonna show the animation before.

What u need TO DO : 
1. Set your Lottie URL (Json FORMAT) : 
example : 'https://cache_lottie_network.json
2. Set your Widget : 
I Recommend you to using Widget like "Circular Progress Indicator" or "SkeletonAvatar". Because this widget gonna show when :
    - Your device already didnt have a connection before you load the animation before.
    - Your local storage in this package is null and you didnt have connection
3. Set your Keys : 
Why ? Because this package using local storage and need keys ! 
If you using this package more than one, never use the same keys. 
example : 
    - CacheLottieNetwork(
        LottieUrl : "https://loremipsum.json"
        function : "CircularProgressIndicator()"
        keys : "lottie1"
    )
     - CacheLottieNetwork(
        LottieUrl : "https://loremipsum.json"
        function : "CircularProgressIndicator()"
        keys : "lottie2"
    )

