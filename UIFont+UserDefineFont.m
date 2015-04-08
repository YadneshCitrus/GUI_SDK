//
//  UIFont+UserDefineFont.m
//  Shaadi
//
//  Created by Rushikesh Khadsare on 11/04/14.
//  Copyright (c) 2014 Shaadi.com. All rights reserved.
//

#import "UIFont+UserDefineFont.h"

@implementation UIFont (UserDefineFont)

+ (UIFont *)customFontWithSize:(float)size{
    NSString *fontName = [NSString stringWithFormat:@"Helvetica"];
    return [UIFont fontWithName:fontName size:size];
}

+ (UIFont *)customObliqueFontWithSize:(float)size{
    NSString *fontName = [NSString stringWithFormat:@"Helvetica-Oblique"];
    return [UIFont fontWithName:fontName size:size];
}

+ (UIFont *)customLightFontWithSize:(float)size{
    NSString *fontName = [NSString stringWithFormat:@"Helvetica-Light"];
    return [UIFont fontWithName:fontName size:size];
}

+ (UIFont *)customBoldFontWithSize:(float)size{
    NSString *fontName = [NSString stringWithFormat:@"Helvetica-Bold"];
    return [UIFont fontWithName:fontName size:size];
}

+ (UIFont *)customBoldObliqueFontWithSize:(float)size{
    NSString *fontName = [NSString stringWithFormat:@"Helvetica-BoldOblique"];
    return [UIFont fontWithName:fontName size:size];
}

+ (UIFont *)customLightObliqueFontWithSize:(float)size{
    NSString *fontName = [NSString stringWithFormat:@"Helvetica-LightOblique"];
    return [UIFont fontWithName:fontName size:size];
}

@end
