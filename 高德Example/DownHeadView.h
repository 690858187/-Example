//
//  DownHeadView.h
//  高德Example
//
//  Created by 1234 on 16/2/18.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownHeadView;

@protocol DownHeadViewDelegate <NSObject>

- (void)downHeadView:(DownHeadView *) headview didSelectedWithSection:(NSInteger)section isExtension:(BOOL)extension;

@end


@interface DownHeadView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, assign) BOOL isExtension;

@property (nonatomic, weak) id<DownHeadViewDelegate> delegate;

@end
