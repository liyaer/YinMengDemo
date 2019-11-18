//
//  Dwl_MineVC.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_MineVC.h"
#import "Dwl_MineHeader.h"
#import "Dwl_MineColHeader.h"
#import "Dwl_MineColCell.h"
#import "Dwl_LoginVC.h"


static NSString *const mineColHeaderID = @"mineColHeader";
static NSString *const mineColCellID = @"mineColCell";


@interface Dwl_MineVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) Dwl_MineHeader *header;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *sectionOneDatas;
@property (nonatomic,strong) NSArray *sectionTwoDatas;

@end


@implementation Dwl_MineVC

#pragma mark - 懒加载

-(Dwl_MineHeader *)header
{
    if (!_header)
    {
        _header = [[Dwl_MineHeader alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, 200) loginAction:^
        {
            Dwl_LoginVC *vc = [[Dwl_LoginVC alloc] init];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }];
    }
    return _header;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10.0;
        layout.minimumLineSpacing = 10.0;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((DScreenWidth-50)/4, (DScreenWidth-50)/4);
        layout.headerReferenceSize = CGSizeMake(DScreenWidth, 100);
        
        //创建collectionView 通过一个布局策略layout来创建
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, DScreenWidth, DScreenHeight -TabBarHeight -200) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[Dwl_MineColHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:mineColHeaderID];
        //注册Item
        [_collectionView registerNib:[UINib nibWithNibName:@"Dwl_MineColCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:mineColCellID];
    }
    return _collectionView;
}




#pragma mark - 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.header];
    [self.view addSubview:self.collectionView];
    self.sectionOneDatas = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    self.sectionTwoDatas = @[@"1",@"1"];
}




#pragma mark - collectionView delegate

//返回section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//返回每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section ? self.sectionTwoDatas.count : self.sectionOneDatas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Dwl_MineColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mineColCellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%ld",indexPath.row);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        Dwl_MineColHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:mineColHeaderID forIndexPath:indexPath];
        header.titleLab.text = @"测试";
        header.backgroundColor = [UIColor redColor];
        return header;
    }
    return nil;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
