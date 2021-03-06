//
//  AppListModel.h
//  iPadDemo
//
//  Created by Chaosky on 16/3/24.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface AppListModel : NSObject<YYModel>


@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *totalCount;

@property (nonatomic, strong) NSArray *applications;

@end
@interface ApplicationsModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *fileSize;

@property (nonatomic, copy) NSString *itunesUrl;

@property (nonatomic, copy) NSString *lastPrice;

@property (nonatomic, copy) NSString *ratingOverall;

@property (nonatomic, copy) NSString *applicationId;

@property (nonatomic, copy) NSString *favorites;

@property (nonatomic, copy) NSString *ipa;

@property (nonatomic, copy) NSString *releaseNotes;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *downloads;

@property (nonatomic, copy) NSString *releaseDate;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *shares;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *starCurrent;

@property (nonatomic, copy) NSString *starOverall;

@property (nonatomic, copy) NSString *priceTrend;

@property (nonatomic, copy) NSString *expireDatetime;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *desc;

@end

