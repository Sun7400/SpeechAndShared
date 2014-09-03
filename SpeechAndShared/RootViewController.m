//
//  RootViewController.m
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import "RootViewController.h"
#import "ISRViewController.h"
#import "ABNFViewController.h"
#import "TTSViewController.h"
#import "ASRDialogViewController.h"
#import "AFRViewController.h"
#import "UnderstandViewController.h"
#import "TextUnderstanderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Definition.h"
#import "PopupView.h"


@implementation RootViewController

- (instancetype) init
{
    self = [super init];
    
    if (self) {
        
        // ...
    }

    return self;
    
}


#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadOtherView];
}

- (void)loadOtherView
{
//    _functions = @[@"语音识别控件",@"语音听写",@"语义理解",@"语法识别",@"音频流识别",@"语音合成",@"文本语义理解"];
    _functions = @[@"语音识别控件",@"语音听写",@"语义理解",@"语音合成"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"语音示例";
    
    // adjust the UI for iOS 7
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
#endif
    
    UITextView* thumbView = [[UITextView alloc] initWithFrame:CGRectMake(Margin, Margin, self.view.frame.size.width-Margin*2, 170)];
    thumbView.text =@"语音测试模块";
    //thumbView.numberOfLines = 0;
    thumbView.layer.borderWidth = 1;
    thumbView.layer.cornerRadius = 8;
    [self.view addSubview:thumbView];
    thumbView.editable = NO;
    _thumbView = thumbView;
    
    thumbView.font = [UIFont systemFontOfSize:17.0f];
    
    // 文本框大小自适应文字
    //    [thumbView sizeToFit];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, thumbView.frame.origin.y + thumbView.frame.size.height+Margin , self.view.frame.size.width, self.view.frame.size.height- thumbView.frame.size.height-Margin*8) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.scrollEnabled = YES;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
//    // 设置全局按钮颜色
//    UIColor * bkColor = [UIButton appearance].backgroundColor;
//    _popUpView = [[PopupView alloc]initWithFrame:CGRectMake(100, 300, 0, 0)];
//    [UIButton appearance].tintColor = [UIColor whiteColor];
//    [UIButton appearance].backgroundColor = [UIColor colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0];
//    [[UIButton appearanceWhenContainedIn:[RootViewController class], nil] setBackgroundColor: bkColor];
//    [[UIButton appearanceWhenContainedIn:[UIActionSheet class], nil] setBackgroundColor: bkColor];
//    [UINavigationBar appearance].tintColor =[UIColor colorWithRed:28/255.0f green:160/255.0f blue:170/255.0f alpha:1.0];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _functions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_functions objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell ;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            ASRDialogViewController *asrdlg = [[ASRDialogViewController alloc] init];
            [self.navigationController pushViewController:asrdlg animated:YES];
            break;
        }
        case 1:
        {
            ISRViewController * isr = [[ISRViewController alloc]init];
            [self.navigationController pushViewController:isr animated:YES];
            break;
        }
        case 2:
        {
            UnderstandViewController * underCV = [[UnderstandViewController alloc]init];
            [self.navigationController pushViewController:underCV animated:YES];
            break;
        }
//        case 3:
//        {
//            ABNFViewController * abnf = [[ABNFViewController alloc]init];
//            [self.navigationController pushViewController:abnf animated:YES];
//            break;
//        }
//        case 3:
//        {
//            AFRViewController * afr = [[AFRViewController alloc] init];
//            [self.navigationController pushViewController:afr animated:YES];
//            break;
//        }
        case 3:
        {
            TTSViewController * tts = [[TTSViewController alloc]init];
            [self.navigationController pushViewController:tts animated:YES];
            break;
        }
//        case 6:
//        {
//            TextUnderstanderViewController * textSearch = [[TextUnderstanderViewController alloc]init];
//            [self.navigationController pushViewController:textSearch animated:YES];
//            break;
//        }
        default:
        {
            NSAssert1(NO, @"Unexpected value for tableView, %s", __func__);
            break;
        }
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
