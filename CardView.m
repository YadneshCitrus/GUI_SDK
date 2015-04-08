//
//  CardView.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "CardView.h"
#import "Constants.h"

@implementation CardView

-(id)init{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 2.0;
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = UIColorFromRGB(0xC5C3C1).CGColor;
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.layer.shadowRadius = 0.0f;
        self.backgroundColor = [UIColor whiteColor];
 
    }
    return self;
}
@end
