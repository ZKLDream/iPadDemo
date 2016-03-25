//
//  AppListCell.m
//  iPadDemo
//
//  Created by Chaosky on 16/3/24.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "AppListCell.h"
#import <UIImageView+WebCache.h>

@implementation AppListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ApplicationsModel *)model
{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.iconUrl] placeholderImage:[UIImage imageNamed:@"favicon"]];
    self.titleLabel.text = _model.name;
    self.categoryLabel.text = _model.categoryName;
    self.descLabel.text = _model.desc;
}

@end
