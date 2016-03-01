//
//  ParkDatas.h
//  GaoDeExample
//
//  Created by 1234 on 16/1/20.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZYModel.h"
@interface ParksByRegionData : JZYModel

/** 停车场信息ID）*/
@property(nonatomic,copy) NSString * id;

/** 节点编号*/
@property(nonatomic,copy) NSString * node_id;

/** 客户号(企业号)*/
@property(nonatomic,copy) NSString * cust_id;

/** 停车场代码*/
@property(nonatomic,copy) NSString * park_code;

/** 停车场名称*/
@property(nonatomic,copy) NSString * name;

/** 商圈代码*/
@property(nonatomic,copy) NSString * business_code;

/** 商圈名称*/
@property(nonatomic,copy) NSString * business_name;

/** 归属区域代码*/
@property(nonatomic,copy) NSString * region_code;

/** 区域名称*/
@property(nonatomic,copy) NSString * region_name;
/** 停车场容量描述*/
@property(nonatomic,copy) NSString * capacity_desc;

/** 停车场总车位数*/
@property(nonatomic,copy) NSString * capacity_num;

/** 收费金额*/
@property(nonatomic,copy) NSString * feeamt;

/** 剩余车位数*/
@property(nonatomic,copy) NSString * free_num;

/** 场内会员数*/
@property(nonatomic,copy) NSString * member_num;

/** 场内临时车数*/
@property(nonatomic,copy) NSString * temp_num;

/** 可预约车位数*/
@property(nonatomic,copy) NSString * appoint_num;

/** 可预约充电桩数*/
@property(nonatomic,copy) NSString * charge_num;
/** 经度*/
@property(nonatomic,copy) NSString * lng;

/** 纬度*/
@property(nonatomic,copy) NSString * lat;

/** 操作人*/
@property(nonatomic,copy) NSString * user_id;

/** 操作时间*/
@property(nonatomic,copy) NSString * utime;

/** 收费标准索引*/
@property(nonatomic,copy) NSString * feeindex;

/** 收费标准描述*/
@property(nonatomic,copy) NSString * feedesc;

/** 免费时长*/
@property(nonatomic,copy) NSString * freetime;

/** 收费评分:数据字典：收费评分1-便宜2-适中3-偏贵*/
@property(nonatomic,copy) NSString * feelevel;
/** 停车场状态:数据字典：1为上班，2为下*/
@property(nonatomic,copy) NSString * logon;

/** 停车场类型:数据字典：1路内2路外*/
@property(nonatomic,copy) NSString * ptype;

/** 停车场子类型:
 数据字典：路内：(20以内)01收费02党政机关03单位个人04免费05分时免费路外：(20以上)01商圈02景区03宾馆04酒店05政府06小区07园区08写字楼*/
@property(nonatomic,copy) NSString * subtype;

/** 数据是否接入*/
@property(nonatomic,copy) NSString * status;

/** 是否支持畅停卡*0:查询全部1:支持2:不支持*/
@property(nonatomic,copy)NSString *membercarflag;

/** 录入时间*/
@property(nonatomic,copy) NSString * addtime;

/** 接入时间*/
@property(nonatomic,copy) NSString * jointime;

/** 详细地址*/
@property(nonatomic,copy) NSString * address;

/** 停车场描述*/
@property(nonatomic,copy) NSString * remark;

/** 停车场评分:对服务或环境类评分*/
@property(nonatomic,copy) NSString * score;

/** 审核*/
@property(nonatomic,copy) NSString * audit;

/** 采集人ID*/
@property(nonatomic,copy) NSString * collector;

/** 采集时间*/
@property(nonatomic,copy) NSString * collect_time;

/** 删除标记*/
@property(nonatomic,copy) NSString * delflag;

/** 停车场布局长宽*/
@property(nonatomic,copy) NSString * seatarea;
/** 充电桩预约标示*/
@property(nonatomic,copy) NSString * appointflag;

/** 地锁预约标示*/
@property(nonatomic,copy) NSString * islockfix;

/** 在线状态*/
@property(nonatomic,copy) NSString * isonline;

/** 最后心跳时间 */
@property(nonatomic,copy) NSString * heartime;

/** 停车场图片路径*/
@property(nonatomic,copy) NSString * photokey;

/** 停车场会员信息同步版本号*/
@property(nonatomic,copy) NSString * maxvermembertable;

/** 导航结束之后是否选中0：默认没选中 1：没选中 2：选中*/
@property (nonatomic, copy) NSString *isSelect;
/**
 *  判断数据库中是否存在id重复的数据
 *
 *  @return 存在YES不保存 不存在:No 保存
 */
- (BOOL)saveNoRepeatData;

@end
