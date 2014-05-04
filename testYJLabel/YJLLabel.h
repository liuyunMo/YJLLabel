//
//  YJLLabel.h
//  testYJLabel
//
//  Created by huxiaohui on 14-5-1.
//  Copyright (c) 2014年 huxiaohui000. All rights reserved.
//

#import <UIKit/UIKit.h>
enum YJLLabelScollType{
    YJLLabelScollTypeOrder,
    YJLLabelScollTypeCircle,
    YJLLabelScollTypeRevert
};
typedef NSUInteger YJLLabelScollType;

@interface YJLLabel : UIView
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)YJLLabelScollType type;
@end
