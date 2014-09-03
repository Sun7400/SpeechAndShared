//
//  NYHMainViewController.m
//  SpeechAndShared
//
//  Created by FXTX-iOS on 14-8-27.
//  Copyright (c) 2014年 FXTX-iOS. All rights reserved.
//

#import "NYHMainViewController.h"
#import "RootViewController.h"
#import "UMSocial.h"


@interface NYHMainViewController ()

@property (strong, nonatomic) NSArray *mData;

@end


@implementation NYHMainViewController

//@synthesize <#property#>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)setName:(NSString *)name
//{
//    if (_name != name) {
//        
//        [_name release];
//        _name = [name retain];
//    }
//}
//- (NSString *)name
//{
//    return _name;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试";
    
    _mData = @[@"语音模块", @"分享模块"];
    
    // 创建表格
    [self createTableView];
    
//    // 设置导航条背景颜色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0]];
    
    [self test];
}


#warning 测试练习
- (void)test
{
    // nil 和 NULL Nil 的区别
    
    // [NSNull null] 代表空值
    NSArray * arr = [NSArray arrayWithObjects:@"nyh", @"fxtx", [NSNull null],nil];
    
    // 判断数组元素是否为空
    NSString *element = [arr objectAtIndex:2];
    
//    arr = nil;
//    NSString *element2 = [arr lastObject];
    
    NSLog(@"----%@",element);

    if ((NSNull *)element == [NSNull null]) {
        
        NSLog(@"空的数组");
    }
}




- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
}


#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_mData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = _mData[indexPath.section];
    
    // 条件三目运算符，判断选择
    cell.accessoryType = indexPath.section ? UITableViewCellAccessoryNone :   UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            RootViewController *speech = [[RootViewController alloc]init];
            [self.navigationController pushViewController:speech animated:YES];
            
            break;
        }
            
        case 1:
        {
            [self umengShared];
            
             break;
        }
           
            
        default:
            break;
    }
}

// 集成友盟社会化分享
- (void)umengShared
{
    // 注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:@"测试文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:@[UMShareToSina,
                                                  UMShareToTencent,
                                                  UMShareToRenren,
                                                  UMShareToWechatSession,
                                                  UMShareToWechatTimeline,
                                                  UMShareToDouban]
                                       delegate:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
