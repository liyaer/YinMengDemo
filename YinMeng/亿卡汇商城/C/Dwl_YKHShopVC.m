//
//  Dwl_YKHShopVC.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_YKHShopVC.h"

#import "UIImage+CreatImageByColor.h"
#import "Dwl_TabHeaderView.h"
#import "Dwl_DetailVC.h"


/**
 *  模拟功能说明:
 *      1，Nav渐变（两种实现方式）
 *      2，头视图拉伸放大
 *      注意是两个单独的功能，测试时不要放在一起，要先进行单独测试，避免混乱
 */


#define type 1 //实现导航栏渐变的两种方式
//方式1经过我们额外处理后，不受页面切换的影响（操作的是navigationBar.backgroundImage的透明度） 思路：部分，需要操作各个部分达到整体一致效果
//方式2。。。。。。。部分地方仍受页面切换影响（操作的是navigationBar的透明度） 思路：整体
static const CGFloat tabHeaderView_h = 200;


@interface Dwl_YKHShopVC ()<UITableViewDelegate,UITableViewDataSource> {
    CGFloat _navAlpha;
}
@property (nonatomic, strong) UILabel *navTitleView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Dwl_TabHeaderView *tabHeaderView;

@end


@implementation Dwl_YKHShopVC

#pragma mark - 懒加载

- (UILabel *)navTitleView {
    if (!_navTitleView) {
        _navTitleView = [[UILabel alloc] init];
        _navTitleView.text = @"我要这铁棒有何用";
        _navTitleView.textColor = [UIColor colorWithWhite:0.3 alpha:0];
        // 根据文字大小自适应尺寸
        [_navTitleView sizeToFit];
    }
    return _navTitleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tabHeaderView;
        //注册Cell
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"systemCell"];
        /**
         *  通过设置contentInset使页面顶头显示:
         *      方式1，iOS11前后表现不同，之后符合预期，之前详情页有点不同
         *      方式2，...............，都不符合预期
         */
//#if type == 1
//        _tableView.contentInset = UIEdgeInsetsMake(-NavHeight, 0, TabBarHeight, 0);
//#else
//        _tableView.contentInset = UIEdgeInsetsMake(-StatusBarHeight, 0, TabBarHeight, 0);
//#endif
        /**
         *  让系统自己适应顶头显示:
         *      方式1，iOS11前后表现一致，都符合预期
         *      方式2，...........不同，都不符合预期
         */
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBarHeight, 0);
        //结论：方式1 + 系统自适应 实现Nav渐变效果
    }
    return _tableView;
}

- (Dwl_TabHeaderView *)tabHeaderView {
    if (!_tabHeaderView) {
        _tabHeaderView = [[Dwl_TabHeaderView alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, tabHeaderView_h)];
    }
    return _tabHeaderView;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

#if type == 1
    [self setUpNavigationBar];
#endif
    
    [self.view addSubview:self.tableView];
}

// 设置导航栏
- (void)setUpNavigationBar {
    // 传递一个空的UIImage,选择模式为UIBarMetricsDefault来设置导航栏背景为透明, 注意UIImage不能传nil, 如果传nil, 苹果会为你加载一张默认的不透明背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    // 清空导航条的阴影的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    [self.navigationItem setTitleView:self.navTitleView];
}

#pragma mark - tableView dateSource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"--------%ld", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Dwl_DetailVC *vc = [[Dwl_DetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 计算比例
    CGFloat offset_y = scrollView.contentOffset.y;
    if (offset_y < 0) {
        _navAlpha = 0;
        
        //拉伸后的图片的frame应该是同比例缩放。
        CGFloat totalOffset = tabHeaderView_h + ABS(offset_y);
        CGFloat scale = totalOffset / tabHeaderView_h;
        [self.tabHeaderView updateBgViewFrame:CGRectMake(-(DScreenWidth * scale - DScreenWidth) / 2, offset_y, DScreenWidth * scale, totalOffset)];
    } else if (offset_y >= 0 && offset_y < (tabHeaderView_h - NavHeight)) {
        _navAlpha = offset_y / (tabHeaderView_h - NavHeight);
    } else {
        _navAlpha = 0.99;
    }
    
    // 刷新UI
#if type == 1
    // 设置导航条背景图片(根据当前alpha值生成图片)
    UIImage *image = [UIImage createImageWithColor:ThemeColor(_navAlpha)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.navTitleView.textColor = [UIColor colorWithWhite:0 alpha:_navAlpha];
#else
    self.navigationController.navigationBar.alpha = _navAlpha;
#endif
}

#pragma mark - VC Change

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

#if type == 1
    UIImage *image = [UIImage createImageWithColor:ThemeColor(0.99)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
#else //这里可以和方式一达到相同的效果
    self.navigationController.navigationBar.alpha = 0.99;
#endif
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if type == 1
    UIImage *image = [UIImage createImageWithColor:ThemeColor(_navAlpha)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
#else //这里做额外处理也无法达到预期，猜测可能和操作的是navigationBar有关。使用KVO监听测试过，先alpha = _navAlpha，最后alpha = 1
    self.navigationController.navigationBar.alpha = _navAlpha;
#endif
}

@end

