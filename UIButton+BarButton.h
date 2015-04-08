//
//  UIButton+BarButton.h
//  Shaadi
//
//  Created by Rushikesh Khadsare on 26/04/14.
//  Copyright (c) 2014 Shaadi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButton_BarButton)

+ (UIBarButtonItem *)backButtonWithTarget:(id)target andSelector:(NSString *)selectorString withImage:(UIImage *)image;
+ (UIBarButtonItem *)backButtonTarget:(id)target withImageName:(NSString*)imgName;
+ (UIBarButtonItem *)nextButtonWithTarget:(id)target andSelector:(NSString *)selectorString withImage:(UIImage *)image;
+(UIBarButtonItem*)doneButtonWithTarget:(id)target andSelector:(NSString*)selectorString withTitle:(NSString*)title;
@end
