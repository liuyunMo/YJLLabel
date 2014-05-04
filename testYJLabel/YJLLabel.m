//
//  YJLLabel.m
//  testYJLabel
//
//  Created by huxiaohui on 14-5-1.
//  Copyright (c) 2014年 huxiaohui000. All rights reserved.
//

#import "YJLLabel.h"
#import "YJLDrawLabel.h"

#define YJLLABEL_SCROLL_SPEED  3
#define YJLLABEL_SCROLL_TIME_INTERVAL .1F
@interface YJLLabel ()<YJLDrawLabelDelegate>
{
    BOOL shouldScroll;
    float scrollSpeed;
}
@end
@implementation YJLLabel
- (void)dealloc
{
    [_text release];
    [super dealloc];
}
-(void)setType:(YJLLabelScollType)type
{
    _type=type;
    scrollSpeed=fabsf(scrollSpeed);
}
-(void)setText:(NSString *)text
{
    [text retain];
    [_text release];
    _text=text;
    [self createView];
}

-(void)createView
{
    self.clipsToBounds  =YES;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    YJLDrawLabel *label=[[YJLDrawLabel alloc] initWithFrame:self.bounds];
    label.backgroundColor=[UIColor clearColor];
    label.tag=1;
    label.delegate=self;
    [self addSubview:label];
    [label release];
    [label fitFrame];
    
    float contentWidth=label.width;
    
    
    if (contentWidth>self.bounds.size.width) {
        
        if (self.type==YJLLabelScollTypeOrder) {
            YJLDrawLabel *label2=[[YJLDrawLabel alloc] initWithFrame:CGRectMake(label.width, 0, label.width, self.frame.size.height)];
            label2.tag=2;
            label2.backgroundColor=[UIColor clearColor];
            label2.delegate=self;
            [self addSubview:label2];
            [label2 release];
            [label2 fitFrame];
            contentWidth+=label2.width;
        }
        
        scrollSpeed=YJLLABEL_SCROLL_SPEED;
        shouldScroll=YES;
        [NSThread detachNewThreadSelector:@selector(scroll) toTarget:self withObject:nil];
        
        UILongPressGestureRecognizer *longGes=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesActive:)];
        [self addGestureRecognizer:longGes];
        [longGes release];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenMenuController)];
        [self addGestureRecognizer:tap];
        [tap release];
    }
}


-(void)scroll
{
    while (shouldScroll) {
        [NSThread sleepForTimeInterval:YJLLABEL_SCROLL_TIME_INTERVAL];
        [self performSelectorOnMainThread:@selector(scrollOnMainThread) withObject:nil waitUntilDone:YES];
    }
}
-(void)scrollOnMainThread
{
    switch (self.type) {
        case YJLLabelScollTypeCircle:
        {
            YJLDrawLabel *label=(YJLDrawLabel *)[self viewWithTag:1];
            float o_x=label.frame.origin.x;
            if (o_x<self.frame.size.width-label.width) {
                scrollSpeed=-scrollSpeed;
            }
            if (o_x>0) {
                scrollSpeed=-scrollSpeed;
            }
            o_x-=scrollSpeed;
            
            CGRect rect=label.frame;
            rect.origin.x=o_x;
            label.frame=rect;
        }
            break;
            
            
            
        case YJLLabelScollTypeOrder:
        {
            YJLDrawLabel *label=(YJLDrawLabel *)[self viewWithTag:1];
            YJLDrawLabel *label2=(YJLDrawLabel *)[self viewWithTag:2];
            float o_x=label.frame.origin.x;
            if (label2.frame.origin.x<=0) {
                label.tag=2;
                label2.tag=1;
                o_x=0;
            }
            o_x-=scrollSpeed;
            
            label=(YJLDrawLabel *)[self viewWithTag:1];
            label2=(YJLDrawLabel *)[self viewWithTag:2];
            
            CGRect rect=label.frame;
            rect.origin.x=o_x;
            label.frame=rect;
            
            CGRect rect2=label2.frame;
            rect2.origin.x=o_x+label.width;
            label2.frame=rect2;

        }
            break;
            
            
            
        case YJLLabelScollTypeRevert:
        {
            YJLDrawLabel *label=(YJLDrawLabel *)[self viewWithTag:1];
            float o_x=label.frame.origin.x;
            if (o_x<self.frame.size.width-label.width) {
                o_x=scrollSpeed;
            }
            o_x-=scrollSpeed;
            
            CGRect rect=label.frame;
            rect.origin.x=o_x;
            label.frame=rect;
        }
            break;
    }
    
}
#pragma mark--  YJLDrawLabelDelegate
-(NSString *)drawText
{
    return self.text;
}
-(UIColor *)drawTextColor
{
    return [UIColor orangeColor];
}
-(UIFont *)drawFont
{
    return [UIFont boldSystemFontOfSize:15];
}
#pragma mark--  Ges handle
-(void)longGesActive:(UILongPressGestureRecognizer *)longGes
{
    if (longGes.state==UIGestureRecognizerStateBegan) {
        [self hiddenMenuController];
        [self becomeFirstResponder];
        UIMenuItem *item=[[UIMenuItem alloc] initWithTitle:self.text action:@selector(doNothing)];
        UIMenuController *menu=[UIMenuController sharedMenuController];
        menu.menuItems=@[item];
        [menu setTargetRect:self.bounds inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
}
-(void)hiddenMenuController
{
    [self resignFirstResponder];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}
-(void)doNothing
{
    
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return action==@selector(doNothing);
}
@end
