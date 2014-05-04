//
//  YJLDrawLabel.h
//  testYJLabel
//
//  Created by huxiaohui on 14-5-1.
//  Copyright (c) 2014年 huxiaohui000. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YJLDrawLabelDelegate;
@interface YJLDrawLabel : UIView
@property(nonatomic,assign)id<YJLDrawLabelDelegate> delegate;
@property(nonatomic,readonly)float width;
-(void)redraw;
-(void)fitFrame;
@end
@protocol YJLDrawLabelDelegate <NSObject>

@required
@property(nonatomic,readonly)NSString   *drawText;
@property(nonatomic,readonly)UIColor    *drawTextColor;
@property(nonatomic,readonly)UIFont     *drawFont;

@end