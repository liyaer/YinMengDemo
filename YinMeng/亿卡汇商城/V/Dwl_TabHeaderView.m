//
//  Dwl_TabHeaderView.m
//  YinMeng
//
//  Created by Mac on 2019/10/29.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import "Dwl_TabHeaderView.h"


@interface Dwl_TabHeaderView ()

@property (nonatomic, strong) UIImageView *bgImgView;

@end


@implementation Dwl_TabHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self addSubview:self.bgImgView];
#warning 设置bgImgView的frame，不能使用约束（尤其xib view的时候会经常性的使用约束），iOS11之后拉伸头视图会出现莫名的bug。------------待验证
    self.bgImgView.frame = self.bounds;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImgView;
}

- (void)updateBgViewFrame:(CGRect)frame {
    self.bgImgView.frame = frame;
}

@end
