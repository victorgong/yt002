//
//  FSPointGiftDetailViewController.m
//  FashionShop
//
//  Created by HeQingshan on 13-4-28.
//  Copyright (c) 2013年 Fashion. All rights reserved.
//

#import "FSPointGiftDetailViewController.h"
#import "FSPointGiftListCell.h"
#import "FSPointExDescCell.h"
#import "FSExchangeRequest.h"
#import "FSUser.h"

@interface FSPointGiftDetailViewController ()
{
    FSGiftListItem *_data;
}

@end

@implementation FSPointGiftDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"积点礼券详情";//NSLocalizedString(@"Point Activity List", nil);
    UIBarButtonItem *baritemCancel = [self createPlainBarButtonItem:@"goback_icon.png" target:self action:@selector(onButtonBack:)];
    [self.navigationItem setLeftBarButtonItem:baritemCancel];
    
    _tbAction.backgroundView = nil;
    _tbAction.backgroundColor = APP_TABLE_BG_COLOR;
    _tbAction.separatorColor = [UIColor clearColor];
    
    //加载数据
    FSExchangeRequest *request = [[FSExchangeRequest alloc] init];
    request.routeResourcePath = RK_REQUEST_STOREPROMOTION_COUPON_DETAIL;
    request.storeCouponId = _requestID;
    request.userToken = [[FSUser localProfile] uToken];
    [self beginLoading:_tbAction];
    _tbAction.hidden = YES;
    [request send:[FSGiftListItem class] withRequest:request completeCallBack:^(FSEntityBase *respData) {
        [self endLoading:_tbAction];
        _tbAction.hidden = NO;
        if (respData.isSuccess)
        {
            _data = respData.responseData;
            if (_data.status == 1) {
                _tbAction.tableFooterView = [self createTableFooterView];
            }
            [_tbAction reloadData];
        }
        else
        {
            [self reportError:respData.errorDescrip];
        }
    }];
}

- (IBAction)onButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTbAction:nil];
    [super viewDidUnload];
}

-(UIView*)createTableFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    view.backgroundColor = [UIColor clearColor];
    
    int xOffset = 49;
    int yOffset = 30;
    
    UIButton *btnClean = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClean.frame = CGRectMake(xOffset, yOffset, 222, 40);
    [btnClean setTitle:NSLocalizedString(@"Cancel Point Exchange", nil) forState:UIControlStateNormal];
    [btnClean setBackgroundImage:[UIImage imageNamed:@"btn_bg.png"] forState:UIControlStateNormal];
    [btnClean setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnClean addTarget:self action:@selector(pointExchangeCancel:) forControlEvents:UIControlEventTouchUpInside];
    btnClean.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [view addSubview:btnClean];
    return view;
}

-(void)pointExchangeCancel:(UIButton*)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要取消兑换吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#define Point_Gift_Info_Cell_Indentifier @"FSPointGiftInfoCell"
#define Point_Gift_Common_Indentifier @"FSPointExCommonCell"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FSPointGiftInfoCell *cell = (FSPointGiftInfoCell*)[tableView dequeueReusableCellWithIdentifier:Point_Gift_Info_Cell_Indentifier];
        if (cell == nil) {
            NSArray *_array = [[NSBundle mainBundle] loadNibNamed:@"FSPointGiftListCell" owner:self options:nil];
            if (_array.count > 0) {
                cell = (FSPointGiftInfoCell*)_array[1];
            }
            else{
                cell = [[FSPointGiftInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Point_Gift_Info_Cell_Indentifier];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setData:_data];
        
        return cell;
    }
    if (indexPath.row == 1) {
        FSPointExCommonCell *cell = (FSPointExCommonCell*)[tableView dequeueReusableCellWithIdentifier:Point_Gift_Common_Indentifier];
        if (cell == nil) {
            NSArray *_array = [[NSBundle mainBundle] loadNibNamed:@"FSPointExDescCell" owner:self options:nil];
            if (_array.count > 0) {
                cell = (FSPointExCommonCell*)_array[2];
            }
            else{
                cell = [[FSPointExCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Point_Gift_Common_Indentifier];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.title = @"使用范围";
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < _data.promotion.inscopenotices.count; i++) {
            FSCommon *item = _data.promotion.inscopenotices[i];
            [str appendFormat:@"使用门店：%@\n使用范围：%@\n", item.storename, item.excludes];
            break;//暂时只增加一个
        }
        cell.desc = str;
        [cell setData];
        
        return cell;
    }
    if (indexPath.row == 2) {
        FSPointExCommonCell *cell = (FSPointExCommonCell*)[tableView dequeueReusableCellWithIdentifier:Point_Gift_Common_Indentifier];
        if (cell == nil) {
            NSArray *_array = [[NSBundle mainBundle] loadNibNamed:@"FSPointExDescCell" owner:self options:nil];
            if (_array.count > 0) {
                cell = (FSPointExCommonCell*)_array[2];
            }
            else{
                cell = [[FSPointExCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Point_Gift_Common_Indentifier];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.title = @"注意事项";
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@", _data.promotion.notice];
        cell.desc = str;
        [cell setData];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 260;
    }
    else{
        FSPointExCommonCell *cell = (FSPointExCommonCell*)[tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        FSExchangeRequest *request = [[FSExchangeRequest alloc] init];
        request.routeResourcePath = RK_REQUEST_STOREPROMOTION_CANCEL;
        request.storeCouponId = _requestID;
        request.userToken = [[FSUser localProfile] uToken];
        [self beginLoading:_tbAction];
        [request send:[FSExchangeSuccess class] withRequest:request completeCallBack:^(FSEntityBase *respData) {
            [self endLoading:_tbAction];
            if (respData.isSuccess)
            {
//                FSExchangeSuccess *__data = respData.responseData;
                _tbAction.tableFooterView = nil;
                [self reportError:@"取消兑换成功"];
            }
            else
            {
                [self reportError:respData.errorDescrip];
            }
        }];
    }
}

@end
