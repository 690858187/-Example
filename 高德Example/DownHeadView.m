//
//  DownHeadView.m
//  高德Example
//
//  Created by 1234 on 16/2/18.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "DownHeadView.h"

@interface DownHeadView ()

@property (nonatomic, strong) UILabel *titleLable;



@end

@implementation DownHeadView


- (id)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
        
    }
    return self;
}

- (void)setupView {
    
    self.titleLable = [UILabel new];
    self.titleLable.textColor = [UIColor blackColor];
    [self addSubview:self.titleLable];
    
    self.titleLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.titleLable addGestureRecognizer:tap];
}

- (void)layoutUI {
    
    self.titleLable.frame = CGRectMake(12, 0, self.frame.size.width, self.frame.size.height);
    
}

- (void)tapAction {
    
    if ([self.delegate respondsToSelector:@selector(downHeadView:didSelectedWithSection:isExtension:)]) {
        [self.delegate downHeadView:self didSelectedWithSection:self.section isExtension:!self.isExtension];
        self.isExtension = !self.isExtension;
    }
}

#pragma mark-----setting&&getting

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLable.text = title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
