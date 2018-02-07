//
//  ViewController.m
//  HJSnapshotDemo
//
//  Created by WHJ on 2018/1/10.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJTableViewCell.h"
#import "UIImage+HJSnapshot.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;

@end

static NSString *const kTableCellIdentifier = @"HJTableViewCell";
static const CGFloat kRowHeight = 300.f;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - About UI
- (void)setupUI{
    
    
    UIButton * snapshotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    snapshotBtn.frame = CGRectMake(0, 0, 44, 44);
    snapshotBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [snapshotBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [snapshotBtn setTitle:@"截图" forState:UIControlStateNormal];
    [snapshotBtn addTarget:self action:@selector(snapshotAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:snapshotBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedRowHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableCellIdentifier];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - Pravite Method

#pragma mark - Public Method

#pragma mark - Event response
- (void)snapshotAction:(UIButton *)sender
{
    CGPoint originOffset = self.tableView.contentOffset;
    
    self.tableView.contentOffset = CGPointZero;
    NSMutableArray * combineImages = [NSMutableArray array];
    UIImage * firstImage =[UIImage snapshotViewFromRect:self.tableView.frame withView:self.tableView saveToAlbum:NO];
    [combineImages addObject:firstImage];
    
    BOOL needBreak = YES;
    while(needBreak){
        CGFloat totalH = self.tableView.contentSize.height;
        CGFloat offsetY = self.tableView.contentOffset.y;
        CGFloat currentH = offsetY + CGRectGetHeight(self.tableView.frame);
        CGFloat leftH = (totalH - currentH);
        needBreak = leftH>=CGRectGetHeight(self.tableView.frame);
        CGFloat rectH = needBreak?CGRectGetHeight(self.tableView.frame):leftH;
        CGRect scrollRect = CGRectMake(0, currentH, CGRectGetWidth(self.tableView.frame), rectH);
        self.tableView.contentOffset = CGPointMake(0, currentH);
        UIImage *image = [UIImage snapshotViewFromRect:scrollRect withView:self.tableView saveToAlbum:NO];
        [combineImages addObject:image];
    }
    
    UIImage * combineImage = [UIImage combineWithImages:combineImages withMargin:0];
    self.tableView.contentOffset = originOffset;
    
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];

    [lib writeImageToSavedPhotosAlbum:[combineImage CGImage] orientation:(ALAssetOrientation)[combineImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if (error) {
            
        } else {
            
        }
    }];
    
}
#pragma mark - Delegate methods

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCellIdentifier];
    NSString *imageName = [NSString stringWithFormat:@"%zd.jpg",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRowHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001f;
}
#pragma mark - Getters/Setters/Lazy

@end
