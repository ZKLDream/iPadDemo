//
//  AppListCell.h
//  iPadDemo
//
//  Created by Chaosky on 16/3/24.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppListModel.h"

@interface AppListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
// 绑定数据模型
@property (nonatomic, strong) ApplicationsModel * model;

@end
