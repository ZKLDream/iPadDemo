//
//  AppListModel.m
//  iPadDemo
//
//  Created by Chaosky on 16/3/24.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel

// 关联属性和类
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"applications" : [ApplicationsModel class]};
}

@end
@implementation ApplicationsModel

// 关联属性和JSON的key
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"desc" : @"description"};
}

@end


