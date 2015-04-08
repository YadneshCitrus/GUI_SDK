//
//  UIButton+BarButton.m
//  Shaadi
//
//  Created by Rushikesh Khadsare on 26/04/14.
//  Copyright (c) 2014 Shaadi.com. All rights reserved.
//

#import "UIButton+BarButton.h"

@implementation UIButton (UIButton_BarButton)

+ (UIBarButtonItem *)backButtonWithTarget:(id)target andSelector:(NSString *)selectorString withImage:(UIImage *)image
{
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backbutton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [backbutton setImage:image forState:UIControlStateNormal];
    [backbutton setImage:image forState:UIControlStateHighlighted];
    
    [backbutton addTarget:target action:NSSelectorFromString(selectorString) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    
    return button;
}

+ (UIBarButtonItem *)backButtonTarget:(id)target withImageName:(NSString*)imgName
{
    NSString *strDefaultImagePath;

    if (imgName)
    {
        strDefaultImagePath = imgName;
    }
    
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:strDefaultImagePath];
    backbutton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [backbutton setImage:image forState:UIControlStateNormal];
    [backbutton setImage:image forState:UIControlStateHighlighted];
    [backbutton addTarget:target action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    
    return button;
}

+ (UIBarButtonItem *)nextButtonWithTarget:(id)target andSelector:(NSString *)selectorString withImage:(UIImage *)image
{
    UIButton *nextbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    nextbutton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [nextbutton setImage:image forState:UIControlStateNormal];
    [nextbutton setImage:image forState:UIControlStateHighlighted];
    
    [nextbutton addTarget:target action:NSSelectorFromString(selectorString) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:nextbutton];
    
    return button;
}

+(UIBarButtonItem*)doneButtonWithTarget:(id)target andSelector:(NSString*)selectorString withTitle:(NSString*)title{
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:target action:NSSelectorFromString(selectorString)];
    //doneBtn.tintColor = [UIColor whiteColor];
    return doneBtn ;
    
}

@end
