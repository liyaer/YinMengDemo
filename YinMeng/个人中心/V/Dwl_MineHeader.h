//
//  Dwl_MineHeader.h
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loginAction)(void);

@interface Dwl_MineHeader : UIView

-(instancetype)initWithFrame:(CGRect)frame loginAction:(loginAction)loginBlock;

@end
