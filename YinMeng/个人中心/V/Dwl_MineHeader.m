//
//  Dwl_MineHeader.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_MineHeader.h"


@interface Dwl_MineHeader()
{
    CGRect _frame;
}
@property (weak, nonatomic) IBOutlet UIButton *userIconBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (nonatomic,copy) loginAction loginBlock;

@end


@implementation Dwl_MineHeader

-(instancetype)initWithFrame:(CGRect)frame loginAction:(loginAction)loginBlock
{
    if (self = [super initWithFrame:frame])
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"Dwl_MineHeader" owner:self options:nil] lastObject];
        
        _frame = frame;
        _loginBlock = loginBlock;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = ThemeColor(1.0);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = _frame;
}




#pragma mark - 点击事件

- (IBAction)userIconClick:(UIButton *)sender
{
    if (self.loginBlock)
    {
        self.loginBlock();
    }
}


@end
