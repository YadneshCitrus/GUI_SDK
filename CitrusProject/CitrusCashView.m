//
//  CitrusCashView.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "CitrusCashView.h"
#import "PureLayout.h"
#import "CardView.h"
#import "UIFont+UserDefineFont.h"


@implementation CitrusCashView
-(id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addHeading];
        [self addDetailView];
    }
    return self ;
}
-(void)addHeading{
    heading = [[UILabel alloc]init];
    [self addSubview:heading];
    heading.text = @"CITRUS CASH" ;
    heading.font = [UIFont customLightFontWithSize:14];
    [heading autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [heading autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [heading autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [heading autoSetDimension:ALDimensionHeight toSize:20];
}

-(void)addDetailView{
     view = [[CardView alloc]init];
    [self addSubview:view];
    
    [view autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [view autoSetDimension:ALDimensionHeight toSize:200];
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:heading withOffset:10];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Cash-Icon"]];
    [view addSubview:iconImage];
    
    [iconImage autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [iconImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
}
@end
