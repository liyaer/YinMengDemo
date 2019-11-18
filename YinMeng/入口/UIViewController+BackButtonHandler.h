//
//  UIViewController+BackButtonHandler.h
//  YinMeng
//
//  Created by Mac on 2019/11/1.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BackButtonHandlerProtocol <NSObject>

/*
 *  设置了backBarButtonItem，请使用该方法
 *  遵循该协议的VC，点击backBarButtonItem时:（点击时自动调用shouldPopItem）
       不实现协议方法，返回上级页面
       实现协议方法，且返回YES，返回上级页面
       实现协议方法，且返回NO，停留在当前页面
 *  若某页面点击返回时想要返回rootVC或者someVC，那么可以在实现的协议方法中，写上新的返回逻辑，比如popToRootVC，最后协议方法返回NO
 */
@optional
- (BOOL)backBarButtonItemHandler;

/*
 *  设置了leftBarButtonItem，请使用该方法
 *  遵循该协议的VC，点击leftBarButtonItem时:（点击时不会调用shouldPopItem）
       不实现协议方法，返回上级页面
       实现协议方法，且方法内写了新的逻辑，按照新逻辑执行
       实现协议方法，但方法内什么也不写，停留在当前页面
 *
 */
@optional
- (void)leftBarButtonItemHandler;

@end


/*
 *  其实无论是设置backBarButtonItem还是leftBarButtonItem，上面的协议完全可以放在baseVC中，这里写成UINavigationController分类，重写shouldPopItem也可以
 *  那么为什么写成这样的形式？原因很简单，既然使用了分类，自然会利用分类的代码分离的作用，协议和shouldPopItem配合共同完成拦截功能模块，因此将二者写在一起
 */
@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end

NS_ASSUME_NONNULL_END
