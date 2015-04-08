//
//  UIFont+UserDefineFont.h
//  Shaadi
//
//  Created by Rushikesh Khadsare on 11/04/14.
//  Copyright (c) 2014 Shaadi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (UserDefineFont)

+ (UIFont *)customFontWithSize:(float)size;
+ (UIFont *)customObliqueFontWithSize:(float)size;
+ (UIFont *)customLightFontWithSize:(float)size;
+ (UIFont *)customBoldFontWithSize:(float)size;
+ (UIFont *)customBoldObliqueFontWithSize:(float)size;
+ (UIFont *)customLightObliqueFontWithSize:(float)size;


//Font Families of Helvetica

/*
 "Helvetica-Oblique",
 "Helvetica-Light",
 "Helvetica-Bold",
 Helvetica,
 "Helvetica-BoldOblique",
 "Helvetica-LightOblique"
 */

@end
