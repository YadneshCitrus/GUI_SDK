//
//  HomeViewController.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "HomeViewController.h"
#import "AddCardController.h"
#import "WebGatewayViewController.h"
#import "BanksViewController.h"

@interface HomeViewController ()
@property(nonatomic,strong) BanksViewController *banksViewController ;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBalanceLabel];

    
    [self addScrollView];
    // Do any additional setup after loading the view.
    
    _banksViewController = [[BanksViewController alloc]initWithNibName:nil bundle:nil];
    self.banksViewController.delegate = self;
}

-(void)addBalanceLabel{
    balanceLbl = [[UILabel alloc]init];
    balanceLbl.font = [UIFont customLightFontWithSize:18];
    balanceLbl.textAlignment = NSTextAlignmentRight;
    [balanceLbl setTextColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar addSubview:balanceLbl];
    balanceLbl.text = [NSString stringWithFormat:@"₹%@",@"1200.00"];
    
    [balanceLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [balanceLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:100];
    [balanceLbl autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [balanceLbl autoSetDimension:ALDimensionHeight toSize:30];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    balanceLbl.hidden = NO;
    ResultController *result = [[ResultController alloc] init];
    result.delegate = self;

}

- (void)viewWillDisappear:(BOOL)animated {
    if (isShowBalance) {
        balanceLbl.hidden = NO;
    }else{
        balanceLbl.hidden = YES;
    }
    [super viewWillDisappear:animated];
}


-(void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    
    CitrusCashView *citrusCash = [[CitrusCashView alloc]init];
    citrusCash.delegate = self;
    [scrollView addSubview:citrusCash];
    
    [citrusCash autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [citrusCash autoSetDimension:ALDimensionHeight toSize:240];
    [citrusCash autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:scrollView];
    [citrusCash autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    
    //
    CustomTableView *saveCards = [[CustomTableView alloc]initWithHeading:SAVE_CARD];
    saveCards.delegate = self;
    [scrollView addSubview:saveCards];
    
    [saveCards autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:citrusCash withOffset:0];
    [saveCards autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:scrollView];
    [saveCards autoSetDimension:ALDimensionHeight toSize:(60)*3];
    [saveCards autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    //
    CustomTableView *creditDebit = [[CustomTableView alloc]initWithHeading:DEBIT_CREDIT_CARD];
    creditDebit.delegate = self;
    [scrollView addSubview:creditDebit];
    
    [creditDebit autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:saveCards withOffset:50];
    [creditDebit autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:scrollView];
    [creditDebit autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [creditDebit autoSetDimension:ALDimensionHeight toSize:(60)*1];

    //
    CustomTableView *netBanking = [[CustomTableView alloc]initWithHeading:NET_BANKING];
    netBanking.delegate = self;
    [scrollView addSubview:netBanking];
    
    [netBanking autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:creditDebit withOffset:50];
    [netBanking autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:scrollView];
    [netBanking autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [netBanking autoSetDimension:ALDimensionHeight toSize:(60)*4];

    scrollView.contentSize = CGSizeMake(0, 900);
    scrollView.showsVerticalScrollIndicator = NO;
}


- (void)loadWebGatewayViewController{
    isShowBalance = YES;
    dispatch_async(dispatch_get_main_queue(), ^(){
        WebGatewayViewController *webGatewayViewController = [[WebGatewayViewController alloc] init];
        [self.navigationController pushViewController:webGatewayViewController animated:YES];
    });
}

#pragma ResultControllerProtocol Delegates

//
-(void)retryTransction{
    NSLog(@"retryTransction Tapped");
    [self payNowWithCitrusCash];
}


#pragma CitrusCashViewProtocol Delegates

//
- (void)payNowWithCitrusCash{
    NSLog(@"Pay Now Tapped");
    [self loadWebGatewayViewController];
}


//
- (void)addMoneyAndPayNowWithCitrusCash{
    NSLog(@"Add Money Tapped");
    isShowBalance = NO;
    dispatch_async(dispatch_get_main_queue(), ^(){
        AddCardController *addCard = [[AddCardController alloc]initWithNibName:nil bundle:nil];
        addCard.payWithCard = YES;
        [self.navigationController pushViewController:addCard animated:YES];
    });
}


#pragma CustomTableViewProtocol Delegates

//
- (void)payWithSavedCards{
    NSLog(@"payWithSavedCards Tapped");
    [self loadWebGatewayViewController];
}

//
- (void)addCard{
    NSLog(@"addCard Tapped");
    isShowBalance = NO;
    dispatch_async(dispatch_get_main_queue(), ^(){
        AddCardController *addCard = [[AddCardController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:addCard animated:YES];
    });
}


//
- (void)payWithCreditDebitCard{
    NSLog(@"payWithCreditDebitCard Tapped");
    dispatch_async(dispatch_get_main_queue(), ^(){
        AddCardController *addCard = [[AddCardController alloc]initWithNibName:nil bundle:nil];
        addCard.payWithCard = YES;
        [self.navigationController pushViewController:addCard animated:YES];
    });
}

//
- (void)payWithNetBanking{
    NSLog(@"payWithNetBanking Tapped");
    [self loadWebGatewayViewController];
}

//
- (void)payWithOtherNetBanking{
    NSLog(@"payWithOtherNetBanking Tapped");
    [self loadWebGatewayViewController];
}

//
- (void)getPayWithOtherNBsViewController{
    NSLog(@"payWithOtherNBs Tapped");
    isShowBalance = YES;
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.navigationController pushViewController:self.banksViewController animated:YES];
    });
}


@end
