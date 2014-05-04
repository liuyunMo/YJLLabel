//
//  YJLDrawLabel.m
//  testYJLabel
//
//  Created by huxiaohui on 14-5-1.
//  Copyright (c) 2014年 huxiaohui000. All rights reserved.
//

#import "YJLDrawLabel.h"

@implementation YJLDrawLabel
-(float)width
{
    NSString *drawStr=[self getDrawString:[self.delegate drawText]];
    UIFont   *font=[self.delegate drawFont];
    return [drawStr sizeWithFont:font].width;
}
-(void)fitFrame
{
    CGRect rect=self.frame;
    rect.size.width=self.width;
    self.frame=rect;
}
-(void)redraw
{
    [self fitFrame];
    [self setNeedsDisplay];
}
-(NSString *)getDrawString:(NSString *)string
{
    NSMutableString *str=[NSMutableString stringWithString:string];
    
    [str replaceOccurrencesOfString:@"\r\n" withString:@"\n" options:NSRegularExpressionSearch range:NSMakeRange(0, str.length)];
    [str replaceOccurrencesOfString:@"\n" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, str.length)];
    
    return str;
}
- (void)drawRect:(CGRect)rect
{
    NSString *drawStr=[self getDrawString:[self.delegate drawText]];
    UIFont   *font=[self.delegate drawFont];
    UIColor  *color=[self.delegate drawTextColor];
    float height=[drawStr sizeWithFont:font].height;
    float y=(rect.size.height-height)/2;
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(ctx);
    
    CGContextSaveGState(ctx);
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, rect);
    CGContextRestoreGState(ctx);
    
    CGContextSaveGState(ctx);
    [color setFill];
    [drawStr drawInRect:CGRectMake(0, y, self.width, height) withFont:font];
    CGContextRestoreGState(ctx);
    
    UIGraphicsPopContext();
}
@end
