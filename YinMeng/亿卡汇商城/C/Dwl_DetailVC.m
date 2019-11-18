//
//  Dwl_DetailVC.m
//  YinMeng
//
//  Created by Mac on 2019/10/25.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import "Dwl_DetailVC.h"
#import "Dwl_TestVC.h"


@interface Dwl_DetailVC ()

@end


@implementation Dwl_DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"详情页";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    if (touch.x > 250 && touch.y > 400) {
        Dwl_TestVC *vc = [[Dwl_TestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
