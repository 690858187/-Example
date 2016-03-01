//
//  CustomAnnotationView.m
//  GaoDeExample
//
//  Created by 1234 on 16/1/21.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "CustomAnnotationView.h"

@interface CustomAnnotationView ()

{
    UILabel *numLable;
    UIImageView *imageView;
}

@end

@implementation CustomAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        [self setupView];
        [self layoutUI];
    }
    return self;
}

- (void)setupView {
    
    //AnnotationView会根据传入图片大小实例化大小和位置
    //放在numlable下面会导致覆盖问题
    self.image = [UIImage imageNamed:@"point"];
    
    numLable = [UILabel new];
    numLable.text = @"0";
    numLable.textAlignment = NSTextAlignmentCenter;
    numLable.textColor = [UIColor colorWithRed:29/255 green:151/255 blue:232/255 alpha:1];
    numLable.font = [UIFont systemFontOfSize:12];
    numLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:numLable];
    numLable.frame = self.bounds;
    
   
    
    
}

- (void)layoutUI {
    
}

#pragma mark-----getting&&setting

- (void)setData:(ParksByRegionData *)data {
    
    if ([data.free_num integerValue]>99) {
        numLable.text = @"99+";
    }else {
        numLable.text = data.free_num;
    }
    
   
}



@end
