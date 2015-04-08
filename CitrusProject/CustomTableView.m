//
//  CustomTableView.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "CustomTableView.h"
#import "PureLayout.h"
#import "CardView.h"
#import "UIFont+UserDefineFont.h"
#import "AppUtility.h"
#import "Constants.h"

@implementation CustomTableView

-(id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self ;
}
-(id)initWithHeading:(NSString*)headingName{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addHeading:headingName];
        [self addTableView:headingName];
    }
    return self ;
}
-(void)addHeading:(NSString*)name{
    heading = [[UILabel alloc]init];
    [self addSubview:heading];
    heading.text = name ;
    heading.font = [UIFont customLightFontWithSize:14];
    [heading autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [heading autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [heading autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [heading autoSetDimension:ALDimensionHeight toSize:20];
}
-(void)addTableView:(NSString*)name{
    NSArray *viewStrips = @[];
    if ([name isEqualToString:DEBIT_CREDIT_CARD]) {
        viewStrips = [self getViewForCreditDebit];
    }
    else{
         viewStrips = [self getNetBankingView];
    }
    CardView *cardDetailView = [AppUtility addCardViewDetails:viewStrips];
    [self addSubview:cardDetailView];
    
    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [cardDetailView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:heading withOffset:10];
    [cardDetailView autoSetDimension:ALDimensionHeight toSize:(55+1+2)*2];
}
-(NSArray*)getViewForCreditDebit{
    NSMutableArray *viewsArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<2; i++) {
        
            UIView *background = [[UIView alloc]init];
            //background.backgroundColor = [UIColor blueColor];
            
            UILabel *lbl = [[UILabel alloc]init];
            [background addSubview:lbl];
            lbl.text = @"Pay With Credit Card" ;
            
            [lbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
            [lbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
            [lbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [lbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [viewsArray addObject:background];
    }
    return viewsArray;
}
-(NSArray*)getNetBankingView{
    NSMutableArray *viewsArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<2; i++) {
        
        UIView *background = [[UIView alloc]init];
        //background.backgroundColor = [UIColor blueColor];
        
        UILabel *lbl = [[UILabel alloc]init];
        [background addSubview:lbl];
        lbl.text = @"ICICI BANK" ;
        
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [viewsArray addObject:background];
    }
    return viewsArray;
}
@end
