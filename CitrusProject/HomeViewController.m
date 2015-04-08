//
//  HomeViewController.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "HomeViewController.h"
#import "CitrusCashView.h"
#import "CustomTableView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    
    CitrusCashView *citrusCash = [[CitrusCashView alloc]init];
    [scrollView addSubview:citrusCash];
    
    [citrusCash autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [citrusCash autoSetDimension:ALDimensionHeight toSize:240];
    [citrusCash autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:scrollView];
    [citrusCash autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    
    CustomTableView *creditDebit = [[CustomTableView alloc]initWithHeading:DEBIT_CREDIT_CARD];
    [scrollView addSubview:creditDebit];
    
    [creditDebit autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:citrusCash withOffset:20];
    [creditDebit autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:scrollView];
    [creditDebit autoSetDimension:ALDimensionHeight toSize:(55+1+2)*2+30];
    [creditDebit autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    
    CustomTableView *netBanking = [[CustomTableView alloc]initWithHeading:@"Net Banking"];
    [scrollView addSubview:netBanking];
    
    [netBanking autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:creditDebit withOffset:20];
    [netBanking autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:scrollView];
    [netBanking autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    
    scrollView.contentSize = CGSizeMake(0, 600);
    scrollView.showsVerticalScrollIndicator = NO;
}

@end
