# SwiflyOverlay

I've been working on a side project that requires a full screen menu to be presented. This is my progress so far. 

Enjoy :) 

![Landing image of the app][demo2]
![Demo image of the implementation][demo]

*I'll update this with a gif soon to show off some sweet animations.*

## Implimentation

You will need to create your own menu view, take a look at the `MenuViewController` in the demo. It's a table based menu view.

Create an instance of `OverlayView` and add your menu as a subview.

```swift

overlay = OverlayView()
overlay?.addSubview(menuViewController.view)
```
When ready, present the view by calling `open()` on the overlay instance

```swift
overlay?.open()
```

The overlay view has an inbuilt close button and it could be dismissed using this alone, in the event your implementation needs another way to dismiss the overlay, call `dismissView()` on the overlay instance

```swift
overlay?.dismissView()
```

### Animation

The animations implemented are quite simple, we animate both the `opacity` and `transform.scale` properties using `CAAnimation`

```swift
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.fromValue = 0.0
            fadeAnimation.toValue = 1.0
            fadeAnimation.duration = 0.3
            fadeAnimation.fillMode = kCAFillModeForwards
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.toValue = 1.0
            scaleAnimation.fromValue = 0.8
            scaleAnimation.duration = 0.3
            scaleAnimation.fillMode = kCAFillModeForwards
            
            let groupAnimation = CAAnimationGroup()
            groupAnimation.duration = 0.3
            groupAnimation.animations = [fadeAnimation, scaleAnimation]
            groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

```

The other animations on are menu based, and can be implemented in your custom menuViewController. Take a look at the demo project for more.

## Contribution

Solo project at the moment, but if you want to contribute and make it better, please make a pull request.

## Thanks

Thanks for taking an interest in my work, you can find me on twitter [@edwinbosire](www.twitter.com/edwinbosire)

## Licence 

The MIT License (MIT)

Copyright (c) 2016 Edwin B

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.



[demo]: https://github.com/edwinbosire/SwiflyOverlay/blob/master/demo-menu.png "Demo image"
[demo2]: https://github.com/edwinbosire/SwiflyOverlay/blob/master/demo-landing.png "Landin image"

