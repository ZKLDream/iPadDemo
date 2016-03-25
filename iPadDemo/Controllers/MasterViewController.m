//
//  MasterViewController.m
//  iPadDemo
//
//  Created by Chaosky on 16/3/24.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "MasterViewController.h"
#import "AppListCell.h"
#import "AppListModel.h"

#import <YYModel.h>
#import <AFNetworking.h>
#import <MJRefresh.h>

#define IDENTIFIER @"CELL"

@interface MasterViewController ()

@property (nonatomic, strong) NSMutableArray * dataSourceArray; // 数据源数组
@property (nonatomic, assign) NSInteger currentPage; // 记录当前请求页
@property (nonatomic, strong) AFHTTPSessionManager * sessionManager; // 网络请求对象

- (IBAction)shareAction:(UIBarButtonItem *)sender;



@end

@implementation MasterViewController

// 懒加载
- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

// 懒加载
- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        // 设置请求数据的格式
        // 返回数据格式的序列化，JSON、XML、二进制数据
//        // 二进制数据序列化
//        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        // JSON数据序列化，默认方式
//        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//        // XML数据序列化
//        _sessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配置UITableView
    // 要实现UITableViewCell自动计算行高，满足三个条件：
    // 1. iOS 8
    // 2. 单元格中只有一个可变高度的视图
    // 3. 设置的视图约束，必须建立和父视图的上下约束
    
    // 设置2个步骤：
    // 1. 设置行高为：UITableViewAutomaticDimension
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 2. 设置估算行高为不为0的值
    self.tableView.estimatedRowHeight = 100;
    
    __weak typeof(self) weakSelf = self;
    // 设置MJRefresh
    // 设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf requestWithPage:weakSelf.currentPage];
    }];
    // 设置上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf requestWithPage:weakSelf.currentPage];
    }];
    
    // 首次请求
    [self.tableView.mj_header beginRefreshing];
}

// 请求数据
- (void)requestWithPage:(NSInteger)page
{
    __weak typeof(self) weakSelf = self;
    // 拼接请求地址
    NSString * appListURL = [NSString stringWithFormat:LimitFreeURL, page];
    // 通过AFHTTPSessionManager的GET方式请求数据
    [self.sessionManager GET:appListURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 请求数据成功
        // 首页数据
        if (page == 1) {
            // 移除数据源所有数据
            [weakSelf.dataSourceArray removeAllObjects];
        }
        // 将新请求的数据添加到数据源中
        AppListModel * model = [AppListModel yy_modelWithJSON:responseObject];
        [weakSelf.dataSourceArray addObjectsFromArray:model.applications];
        // 刷新视图
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            // 停止刷新
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error.localizedDescription);
        if (page > 1) {
            weakSelf.currentPage--;
        }
        // 回到主线程刷新视图
        dispatch_async(dispatch_get_main_queue(), ^{
            // 停止刷新
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    // 获取数据模型
    ApplicationsModel * model = self.dataSourceArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark -UITableViewDalegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取选中单元格的数据
    ApplicationsModel * model=self.dataSourceArray[indexPath.row];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MasterToDetailNotfication object:model.applicationId];//发送者 可以传值
    
    
}


//懒加载
- (IBAction)shareAction:(UIBarButtonItem *)sender {
    
    //创建ContentVC
    UIImagePickerController *pickerVC=[[UIImagePickerController alloc]init];
    pickerVC.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    pickerVC.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    //创建UIPopoverController
    UIPopoverController *popoverVC=[[UIPopoverController alloc]initWithContentViewController:pickerVC];
    
    //显示
 //   [popoverVC presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //参数1：指定位置的Rect 在什么地方显示
    [popoverVC presentPopoverFromRect:CGRectMake(50, 50, 200, 200) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
}
@end
