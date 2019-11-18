//
//  LoadingView.h
//  BookReader
//
//  Created by 杜文亮 on 2018/3/13.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^Reload)(void);


@interface Dwl_BaseLoading : UIView

@property (nonatomic,copy) Reload reloadBlock;

//控制属性和方法(如果需要重设frame属性，那么一定在调下面两个方法前重设，因为load和reload的frame会随着self.frame的改变而改变)
@property (nonatomic,assign) CGRect newFrame;
-(void)addLoadRemoveReload;
-(void)removeLoadAddReload;

@end
