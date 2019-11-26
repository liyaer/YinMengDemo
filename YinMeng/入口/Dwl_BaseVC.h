//
//  Dwl_BaseVC.h
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dwl_BaseLoading.h"
#import "Dwl_BaseNav.h"


typedef enum : NSUInteger
{
    DLoadNew,
    DLoadMore,
    DLoadDefault,
}
DLoadType;


@interface Dwl_BaseVC : UIViewController

//属性是为了方便调用LoadingView；方法是为了方便适配LoadingView的frame
//外界使用时要先调用1对_loading初始化，然后才能正常调用LoadingView中的控制方法
-(void)addLoadingWithFrame:(CGRect)frame;//1
@property (nonatomic,strong) Dwl_BaseLoading *loading;//2

//服务器无相应数据，展示提示信息。做成方法更方便frame的适配
-(void)addNoDataWithFrame:(CGRect)frame;


//是否禁用侧滑返回手势
- (void)gesturePopEnable:(BOOL)enable;

@end
