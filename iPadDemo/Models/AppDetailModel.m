//
//  AppDetailModel.m
//  iPadDemo
//
//  Created by 千锋 on 16/3/25.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "AppDetailModel.h"

@implementation AppDetailModel


+(NSDictionary *)modelCustomPropertyMapper{
    return @{@"desc":@"description"};
    
}


+(NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"photos":[PhotosModel class]};
}


@end
@implementation PhotosModel

@end


