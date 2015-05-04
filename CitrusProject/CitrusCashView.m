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
#import "AppUtility.h"

@implementation CitrusCashView
@synthesize delegate;

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
    [view autoSetDimension:ALDimensionHeight toSize:180];
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:heading withOffset:10];
    
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Cash-Icon"]];
    [view addSubview:iconImage];
    
    [iconImage autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [iconImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    
    
    NSArray *viewStrips = @[[self balanceView],
                            [self payNowView],
                            [self addMoneyAndPayNowView]];
    CardView *detailView = [AppUtility addCardViewDetails:viewStrips];
    [view addSubview:detailView];

    [detailView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [detailView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:50];
    [detailView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [detailView autoSetDimension:ALDimensionHeight toSize:(60)*3];
    
    detailView.backgroundColor = [UIColor whiteColor];
}

-(UIView*)balanceView{
    UIView *background = [[UIView alloc]init];
    
    balanceLbl = [[UILabel alloc]init];
    balanceLbl.font = [UIFont customBoldFontWithSize:22];
    [balanceLbl setTextColor:[UIColor colorWithRed:(97/255.f) green:(189/255.f) blue:(0/255.f) alpha:1.0f]];
    [background addSubview:balanceLbl];
    balanceLbl.text = [NSString stringWithFormat:@"₹%@",@"1200.00"];
    
    [balanceLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [balanceLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [balanceLbl autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4];
    [balanceLbl autoSetDimension:ALDimensionHeight toSize:30];
    
    UILabel *yourbalanceLbl = [[UILabel alloc]init];
    yourbalanceLbl.font = [UIFont customLightFontWithSize:14];
    [yourbalanceLbl setTextColor:[UIColor colorWithRed:(126/255.f) green:(127/255.f) blue:(126/255.f) alpha:1.0f]];
    [background addSubview:yourbalanceLbl];
    yourbalanceLbl.text = @"Your Balance";
    
    [yourbalanceLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [yourbalanceLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [yourbalanceLbl autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:22];
    [yourbalanceLbl autoSetDimension:ALDimensionHeight toSize:30];
    
    return background;
}


-(UIView*)payNowView{
    UIView *background = [[UIView alloc]init];
    UILabel *payNowLbl = [[UILabel alloc]init];
    payNowLbl.font = [UIFont customLightFontWithSize:16];
    [payNowLbl setTextColor:[UIColor colorWithRed:(245/255.f) green:(146/255.f) blue:(28/255.f) alpha:1.0f]];
    [background addSubview:payNowLbl];
    payNowLbl.text = @"Pay Now";
    
    [payNowLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:13];
    [payNowLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [payNowLbl autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
    [payNowLbl autoSetDimension:ALDimensionHeight toSize:30];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payNowTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [payNowLbl addGestureRecognizer:tapGestureRecognizer];
    payNowLbl.userInteractionEnabled = YES;
    return background;
}

//
-(void)payNowTapped{
    NSLog(@"Pay Now Tapped");
    [delegate payNowWithCitrusCash];
}


-(UIView*)addMoneyAndPayNowView{
    
    UIView *background = [[UIView alloc]init];
    UILabel *addMoneyLbl = [[UILabel alloc]init];
    addMoneyLbl.font = [UIFont customLightFontWithSize:16];
    [addMoneyLbl setTextColor:[UIColor blackColor]];
    [background addSubview:addMoneyLbl];
    addMoneyLbl.text = @"Add Money & Pay Now";
    
    [addMoneyLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:13];
    [addMoneyLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [addMoneyLbl autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [addMoneyLbl autoSetDimension:ALDimensionHeight toSize:30];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addMoneyTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [addMoneyLbl addGestureRecognizer:tapGestureRecognizer];
    addMoneyLbl.userInteractionEnabled = YES;

    return background;
}

//
-(void)addMoneyTapped{
    NSLog(@"Add Money Tapped");
    [delegate addMoneyAndPayNowWithCitrusCash];
}




@end
