//
//  Dwl_LoginVC.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_LoginVC.h"
#import "NSString+atStr.h"


@interface Dwl_LoginVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopSpace;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end


@implementation Dwl_LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.toTopSpace.constant = StatusBarHeight +20;
    
    self.loginBtn.layer.cornerRadius = 25;
    self.loginBtn.backgroundColor = ThemeColor(1.0);
    
    self.accountTF.borderStyle = UITextBorderStyleNone;
    self.accountTF.attributedPlaceholder = [NSString atStrWithString:self.accountTF.placeholder Attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} Range:NSMakeRange(0, self.accountTF.placeholder.length)];
    self.passwordTF.borderStyle = UITextBorderStyleNone;
    self.passwordTF.attributedPlaceholder = [NSString atStrWithString:self.passwordTF.placeholder Attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} Range:NSMakeRange(0, self.passwordTF.placeholder.length)];
}

- (IBAction)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtnClicked:(id)sender
{
    if ([Dwl_NetWork instance].hasNet)
    {
        if (self.accountTF.text.length && self.passwordTF.text.length)
        {
            
        }
        else
        {
            [Dwl_TipView showHUD:@"请将信息填写完整~" showTime:2.0];
        }
    }
    else
    {
        NoNetTip;
    }
}

- (IBAction)forgetBtnClicked:(id)sender
{
    
}

- (IBAction)registBtnClicked:(id)sender
{
    
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
