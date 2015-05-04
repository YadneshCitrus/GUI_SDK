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
#import "AddCardController.h"

@implementation CustomTableView
@synthesize delegate;

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

    if ([name isEqualToString:SAVE_CARD]) {
//        viewStrips = [self getSaveCards];
//        cardDetailView = [AppUtility addCardViewDetails:viewStrips];
        [self saveCardsView];
    }else if ([name isEqualToString:DEBIT_CREDIT_CARD]) {
        viewStrips = [self getViewForCreditDebit];
        cardDetailView = [AppUtility addCardViewDetails:viewStrips];
    }else if ([name isEqualToString:NET_BANKING]){
         viewStrips = [self getNetBankingView];
        cardDetailView = [AppUtility addCardViewDetailsForNB:viewStrips];
    }

    [self addSubview:cardDetailView];
    
    
    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [cardDetailView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:heading withOffset:10];
    [cardDetailView autoSetDimension:ALDimensionHeight toSize:(60)*[viewStrips count]];
}
 
-(void)saveCardsView{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:heading withOffset:10];
    [tableView autoSetDimension:ALDimensionHeight toSize:(60)*2];
    
    
    UILabel *lbl = [[UILabel alloc]init];
    lbl.backgroundColor = [UIColor whiteColor];
    lbl.font = [UIFont customLightFontWithSize:16];
    [lbl setTextColor:[UIColor colorWithRed:(245/255.f) green:(146/255.f) blue:(28/255.f) alpha:1.0f]];
    lbl.text = @"              Add Card" ;
    [self addSubview:lbl];
    
    UITapGestureRecognizer *tapGestureRecognizer;
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCard)];
    lbl.userInteractionEnabled = YES;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [lbl addGestureRecognizer:tapGestureRecognizer];

    [lbl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tableView withOffset:0];
    [lbl autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:tableView];
    [lbl autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [lbl autoSetDimension:ALDimensionHeight toSize:(60)*1];

}



- (void)addCard{
    NSLog(@"addCard Tapped");
    [self.delegate addCard];
}

#pragma TableView Delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return [your array count];
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //    cell.textLabel.text = [yourarray objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"visa"];
//    [cell.imageView autoSetDimension:ALDimensionHeight toSize:44];

    cell.textLabel.text = @"XXXX XXXXX XXXX 3334";
    cell.textLabel.font = [UIFont customLightFontWithSize:16];
    
    cell.detailTextLabel.text = @"Debit Card - ICICI";
    cell.detailTextLabel.font = [UIFont customLightFontWithSize:12];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath Tapped %ld",(long)indexPath.row);
    [self.delegate payWithSavedCards];
}


-(NSArray*)getViewForCreditDebit{
    NSMutableArray *viewsArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<1; i++) {
        
        UIView *background = [[UIView alloc]init];

        UILabel *lbl = [[UILabel alloc]init];
        lbl.font = [UIFont customLightFontWithSize:16];

        UITapGestureRecognizer *tapGestureRecognizer;
        
        lbl.text = @"Pay With Credit or Debit Card" ;
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payWithCreditDebitCard)];
        
        [background addSubview:lbl];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [viewsArray addObject:background];
        
        lbl.userInteractionEnabled = YES;
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [lbl addGestureRecognizer:tapGestureRecognizer];
    }
    return viewsArray;
}


//
-(void)payWithCreditDebitCard{
    NSLog(@"payWithCreditCard Tapped");
    [self.delegate payWithCreditDebitCard];
}


-(NSArray*)getNetBankingView{
    NSMutableArray *viewsArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<4; i++) {
        
        UIView *background = [[UIView alloc]init];

        UIImageView *iconImage = [[UIImageView alloc] init];
        [background addSubview:iconImage];
        
        UILabel *lbl = [[UILabel alloc]init];
        lbl.font = [UIFont customLightFontWithSize:16];

        UITapGestureRecognizer *tapGestureRecognizer;
        
        if (i==0) {
            iconImage.image = [UIImage imageNamed:@"Bank-ICICI"];
            lbl.text = @"ICICI BANK" ;
            tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payWithNBICICIBank)];
        }else if (i==1){
            iconImage.image = [UIImage imageNamed:@"Bank-Kotak"];
            lbl.text = @"Kotak Mahindra BANK" ;
            tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payWithNBKMBBank)];
        }else if (i==2){
            iconImage.image = [UIImage imageNamed:@"Bank-SBI"];
            lbl.text = @"State Bank of India" ;
            tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payWithNBSBIBank)];
        }else {
            lbl.text = @"Select Other Banks";
            [lbl setTextColor:[UIColor colorWithRed:(245/255.f) green:(146/255.f) blue:(28/255.f) alpha:1.0f]];
            tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payWithOtherBanks)];
        }

        [iconImage autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [iconImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];

        [background addSubview:lbl];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:60];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [lbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [viewsArray addObject:background];
        
        lbl.userInteractionEnabled = YES;
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [lbl addGestureRecognizer:tapGestureRecognizer];
     }
    return viewsArray;
}


//
-(void)payWithNBICICIBank{
    NSLog(@"payWithNBICICIBank Tapped");
    [delegate payWithNetBanking];
}

//
-(void)payWithNBKMBBank{
    NSLog(@"payWithNBKMBBank Tapped");
    [delegate payWithNetBanking];
}

//
-(void)payWithNBSBIBank{
    NSLog(@"payWithNBSBIBank Tapped");
    [delegate payWithNetBanking];
}

//
-(void)payWithOtherBanks{
    NSLog(@"payWithOtherBanks Tapped");
    [delegate getPayWithOtherNBsViewController];
}


@end
