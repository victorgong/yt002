//
//  FSPointExDescCell.h
//  FashionShop
//
//  Created by HeQingshan on 13-5-2.
//  Copyright (c) 2013年 Fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "FSExchange.h"
#import "FSCommon.h"

@interface FSPointExDescCell : UITableViewCell

@property (strong, nonatomic) IBOutlet RTLabel *titleView;
@property (strong, nonatomic) IBOutlet RTLabel *activityTime;
@property (strong, nonatomic) IBOutlet RTLabel *useTime;
@property (strong, nonatomic) IBOutlet RTLabel *joinStore;
@property (strong, nonatomic) IBOutlet RTLabel *useScope;
@property (strong, nonatomic) IBOutlet UIImageView *line1;
@property (strong, nonatomic) IBOutlet UIImageView *line2;

@property (nonatomic) int cellHeight;
@property (nonatomic, strong) FSExchange* data;

@end

@interface FSPointExDoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *selStoreBtn;
@property (strong, nonatomic) IBOutlet UILabel *remainPoint;
@property (strong, nonatomic) IBOutlet UITextField *pointExField;
@property (strong, nonatomic) IBOutlet UILabel *exMoney;
@property (strong, nonatomic) IBOutlet UITextField *idCardField;
@property (strong, nonatomic) IBOutlet UIButton *exBtn;
@property (strong, nonatomic) IBOutlet UILabel *pointTipLb;
@property (strong, nonatomic) IBOutlet UILabel *unitPerPoint;

@property (nonatomic) int cellHeight;
@property (nonatomic, strong) FSExchange* data;

@end

typedef enum {
    Ex_Standard,//兑换标准
    Ex_Attention,//注意事项
}ExCommonType;

@interface FSPointExCommonCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *line1;
@property (strong, nonatomic) IBOutlet UILabel *titleView;
@property (strong, nonatomic) IBOutlet UIImageView *line2;
@property (strong, nonatomic) IBOutlet RTLabel *content;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic) ExCommonType type;

@property (nonatomic) int cellHeight;
@property (nonatomic, strong) FSExchange* data;

@end

//礼券使用范围Cell
@interface FSPointScopeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet RTLabel *storeName;
@property (strong, nonatomic) IBOutlet RTLabel *useScope;

@property (nonatomic) int cellHeight;
@property (nonatomic, strong) FSCommon* data;

@end

//礼券兑换成功Cell
@interface FSPointExSuccessCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *giftNumber;
@property (strong, nonatomic) IBOutlet UILabel *exTime;
@property (strong, nonatomic) IBOutlet UILabel *stopTime;
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UILabel *pointCount;
@property (strong, nonatomic) IBOutlet UILabel *moneyCount;

@property (nonatomic) int cellHeight;
@property (nonatomic, strong) FSExchangeSuccess* data;

@end