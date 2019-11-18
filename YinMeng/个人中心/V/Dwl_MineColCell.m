//
//  Dwl_MineColCell.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_MineColCell.h"


@interface Dwl_MineColCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end


@implementation Dwl_MineColCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = ThemeColor(1.0);
    self.titleLab.text = @"测试001";
}




@end
