//
//  Dwl_TabHeaderView.h
//  YinMeng
//
//  Created by Mac on 2019/10/29.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dwl_TabHeaderView : UIView

//为了实现头视图拉伸缩放效果，UIImageView不能直接作为头视图（无法达到预期效果），给它加个父视图达到了效果（UIView -> UIImageView）
- (void)updateBgViewFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
