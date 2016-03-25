//
//  DetailViewController.m
//  iPadDemo
//
//  Created by Chaosky on 16/3/24.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDetailModel.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
//等待加载框 菊花转
#import <MBProgressHUD.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *categoryLable;
@property (weak, nonatomic) IBOutlet UILabel *descLable;

@property (weak, nonatomic) IBOutlet UITextView *longDescLable;

@property (nonatomic,strong)AFHTTPSessionManager *httpManager;

@property (nonatomic,strong)AppDetailModel *detailModel;//应用详情
@property (nonatomic,copy)NSString *applicationID;//应用ID

@end





@implementation DetailViewController



-(AFHTTPSessionManager *)httpManager{
    if (!_httpManager) {
        _httpManager=[AFHTTPSessionManager manager];
        _httpManager.responseSerializer.acceptableContentTypes=[_httpManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    return _httpManager;
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateApplicationID:) name:MasterToDetailNotfication object:nil];
    
    
}

-(void)dealloc{
    //移除通知中心的观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)updateApplicationID:(NSNotification *)notif{
    
    self.applicationID=notif.object;
    //取消operationQueue中所有的操作
    [self.httpManager.operationQueue cancelAllOperations];
    
    //请求数据
    [self requestAppDetail];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//请求应用详情数据
-(void)requestAppDetail{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //拼接URL
    NSString * detailURL=[NSString stringWithFormat:AppDetailURL,self.applicationID];
    __weak typeof(self) weakSelf=self;
    //请求数据
    [self.httpManager GET:detailURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        //将json数据转变为模型数据
        weakSelf.detailModel=[AppDetailModel yy_modelWithJSON:responseObject];
        //回到主线程刷新视图
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf updateUI];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
}

-(void)updateUI{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.iconUrl] placeholderImage:[UIImage imageNamed:@"favicon"]];
    self.titleLable.text=self.detailModel.name;
    self.categoryLable.text=self.detailModel.categoryName;
    self.descLable.text=self.detailModel.desc;
    self.longDescLable.text=self.detailModel.description_long;
    
    
}




@end
