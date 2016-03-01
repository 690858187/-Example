//
//  DownLoadMapViewController.m
//  高德Example
//
//  Created by 1234 on 16/2/17.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "DownLoadMapViewController.h"
#import "DownHeadView.h"

static NSString *const tableViewCellIdentifier = @"tableViewCellIdentifier";
@interface DownLoadMapViewController ()<UITableViewDataSource,UITableViewDelegate,DownHeadViewDelegate>

@property (nonatomic, strong) NSArray *hotArry;
/** 城市数组, 包括普通城市与直辖市*/
@property (nonatomic, strong) NSArray *cityArry;
/** 省份数组*/
@property (nonatomic, strong) NSArray *provinceArry;
/** 直辖市数组*/
@property (nonatomic, strong) NSArray *municipalitieArry;

@property (nonatomic, strong) UITableView *mainTable;

@property (nonatomic, assign) NSInteger selectSection;

@property (nonatomic, strong) NSMutableArray *selectSectionArr;

@property (nonatomic, strong) NSMutableDictionary *selectSectionDic;

@end

@implementation DownLoadMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectSection = -1;
    self.selectSectionArr = [NSMutableArray array];
    self.selectSectionDic = [NSMutableDictionary dictionary];
    [self allocArry];
    [self setupView];
    // Do any additional setup after loading the view.
}

/**
 *  获取各城市，省份，或者直辖市数组
 */

- (void)allocArry {
    
    self.hotArry = [NSArray arrayWithArray:[MAOfflineMap sharedOfflineMap].cities];
    self.cityArry = [NSArray arrayWithArray:[MAOfflineMap sharedOfflineMap].cities];
    self.provinceArry = [NSArray arrayWithArray:[MAOfflineMap sharedOfflineMap].provinces];
    self.municipalitieArry = [NSArray arrayWithArray:[MAOfflineMap sharedOfflineMap].municipalities];
}

- (void)setupView {
   
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.mainTable.dataSource = self;
    self.mainTable.delegate = self;
    [self.mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellIdentifier];
    [self.view addSubview:self.mainTable];
}

#pragma mark-----UITableViewDataSource,UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier forIndexPath:indexPath];
    MAOfflineProvince *pro = self.provinceArry[indexPath.section];
    cell.textLabel.text = [self cellLabelTextForItem:pro.cities[indexPath.row]];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger number = 0;

//    for (int i =0 ; i<self.selectSectionArr.count; i++) {
//        
//        NSInteger y = [self.selectSectionArr[i] integerValue];
//        if (y==section) {
//            
//            MAOfflineProvince *pro = self.provinceArry[section];
//            number = pro.cities.count;
//        }
//        
//    }
    
    for (int i =0 ; i<self.selectSectionDic.count; i++) {
        
        NSInteger y = [self.selectSectionArr[i] integerValue];
        if (y==section) {
            
            MAOfflineProvince *pro = self.provinceArry[section];
            number = pro.cities.count;
        }
        
    }
    
  //  NSNumber *number = [self.selectSectionDic objectForKey:[NSString stringWithFormat:@"%ld",section]];
    

    
    return number;

}

//分组

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.provinceArry.count;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    return [self cellLabelTextForItem:self.provinceArry[section]];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section  {
    
    DownHeadView *header = [[DownHeadView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    header.title = [self cellLabelTextForItem:self.provinceArry[section]];
    header.section = section;
    header.delegate = self;
    header.backgroundColor = [UIColor redColor];
    return header;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (NSString *)cellLabelTextForItem:(MAOfflineItem *)item
{
    NSString *labelText = nil;
    
    if (item.itemStatus == MAOfflineItemStatusInstalled)
    {
        labelText = [item.name stringByAppendingString:@"(已安装)"];
    }
    else if (item.itemStatus == MAOfflineItemStatusExpired)
    {
        labelText = [item.name stringByAppendingString:@"(有更新)"];
    }
    else if (item.itemStatus == MAOfflineItemStatusCached)
    {
        labelText = [item.name stringByAppendingString:@"(缓存)"];
    }
    else
    {
        labelText = item.name;
    }
    
    return labelText;
}

#pragma mark-----DownHeadViewDelegate

- (void)downHeadView:(DownHeadView *)headview didSelectedWithSection:(NSInteger)section isExtension:(BOOL)extension {
    if (extension) { //展开
        
        //[self.selectSectionArr addObject:@(section)];
        [self.selectSectionDic setObject:[NSNumber numberWithBool:extension] forKey:[NSString stringWithFormat:@"%ld",section]];
    }
    else {          //不展开
        
        //[self.selectSectionArr removeObject:@(section)];
        [self.selectSectionDic removeObjectForKey:[NSString stringWithFormat:@"%ld",section]];
    }
    
    [self.mainTable reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
