//
//  AppUtility.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "AppUtility.h"
#import "CardView.h"
#import "SepratorLine.h"
#import "PureLayout.h"

@implementation AppUtility

+(CardView*)addCardViewDetails:(NSArray*)viewStrips{
    CardView *cardDetailView = [[CardView alloc]init];
    cardDetailView.backgroundColor = [UIColor whiteColor];
    
    
    NSMutableArray *allViews = [[NSMutableArray alloc]init];
    int count = [viewStrips count]*2 -1 ;
    for (int i = 0; i< count; i++) {
        UIView *vew = [[UIView alloc]init] ;
        if (i%2 == 1) {
            SepratorLine *line = [[SepratorLine alloc]init];
            [cardDetailView addSubview:line];
            
            [line autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
            [line autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
            [line autoSetDimension:ALDimensionHeight toSize:1];
            vew = line ;
            
        }
        else {
            UIView *visaBackground = [viewStrips objectAtIndex:(i/2)];
            [cardDetailView addSubview:visaBackground];
            
            [visaBackground autoPinEdgeToSuperviewEdge:ALEdgeLeading];
            [visaBackground autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
            [visaBackground autoSetDimension:ALDimensionHeight toSize:55];
            vew = visaBackground ;
        }
        [allViews addObject:vew];
        if (i==0) {
            [vew autoPinEdgeToSuperviewEdge:ALEdgeTop];
        }
        else{
            UIView *previousView = [allViews objectAtIndex:i-1];
            [vew autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:previousView withOffset:2];
        }
    }
    return cardDetailView;
}

@end
