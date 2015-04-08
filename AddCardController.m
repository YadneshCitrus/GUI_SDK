//
//  AddCardController.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "AddCardController.h"
#import "SepratorLine.h"
#import "CardView.h"
#import "AppUtility.h"

@interface AddCardController ()

@end

@implementation AddCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add Card";
    [self addBarButton];
    [self addSegmentedController];
    [self addCardViewDetails];
    [self addFooterMessages];
    // Do any additional setup after loading the view.
}
-(void)addBarButton{
    UIBarButtonItem *item = [UIButton doneButtonWithTarget:self andSelector:@"done" withTitle:@"Done"];
    self.navigationItem.rightBarButtonItem = item ;
}
-(void)done{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addSegmentedController{
    segementBackGround = [[CardView alloc]init];
    UISegmentedControl *segementedController = [[UISegmentedControl alloc]initWithItems:@[@"Credit Card",@"Debit Card"]] ;
    [self.view addSubview:segementBackGround];
    [segementBackGround addSubview:segementedController];
    
    [segementBackGround autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [segementBackGround autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [segementBackGround autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [segementBackGround autoSetDimension:ALDimensionHeight toSize:60];
    segementBackGround.backgroundColor = [UIColor whiteColor];
    
    [segementedController autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10.0];
    [segementedController autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10.0];
    [segementedController autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0];
    [segementedController autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.0];
    
    segementedController.selectedSegmentIndex = 0 ;
    
    segementedController.layer.shadowColor = UIColorFromRGB(0xC5C3C1).CGColor;
    segementedController.layer.shadowOpacity = 1.0;
    segementedController.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
}

-(void)addCardViewDetails{
    NSArray *viewStrips = @[[self getVisaCardNumberView],
                            [self getCardExpiryView],
                            [self getCardNameView],
                            [self saveCardOptionView]];
    cardDetailView = [AppUtility addCardViewDetails:viewStrips];
    [self.view addSubview:cardDetailView];
    
    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [cardDetailView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:segementBackGround withOffset:30];
    [cardDetailView autoSetDimension:ALDimensionHeight toSize:(55+1+2)*4];
    
    cardDetailView.backgroundColor = [UIColor whiteColor];
}
-(void)addFooterMessages{
    
    UILabel *footerlbl = [[UILabel alloc]init];
    footerlbl.text = @" Save this card and you won't have to enter these details again!";
    footerlbl.numberOfLines = 0;
    footerlbl.font = [UIFont customBoldFontWithSize:14];
    footerlbl.textColor = [UIColor grayColor];
    [self.view addSubview:footerlbl];
    
    [footerlbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [footerlbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [footerlbl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cardDetailView withOffset:20];
}
-(UIView*)getVisaCardNumberView{
    UIView *background = [[UIView alloc]init];
    //background.backgroundColor = [UIColor redColor];
    //cardNumber = [[UITextField alloc]init];
    UIView *blocks = [self getCardNumberBlocks];
    [background addSubview:blocks];
    
    //TODO: add card image according to card number.
    UIImageView *cardImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CreditCard-VISA"]];
    [background addSubview:cardImage];
    
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12];
    
    [cardImage autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [cardImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:background];
    return background;

}
-(UIView*)getCardNumberBlocks{
    UIView *blocksBackGround = [[UIView alloc]init];
    cardNumberBlocks = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i++ ) {
        UITextField *block = [[UITextField alloc]init];
        block.keyboardType = UIKeyboardTypeNumberPad ; 
        [blocksBackGround addSubview:block];
        block.borderStyle = UITextBorderStyleRoundedRect;
        [block autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:blocksBackGround withMultiplier:0.18];
        [block autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [block autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [cardNumberBlocks addObject:block];
        if (i==0) {
            [block autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        }
        else{
            UITextField *previousBlock = [cardNumberBlocks objectAtIndex:i-1];
            [block autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:previousBlock withOffset:10];
        }
    }
    return blocksBackGround;
}
-(UIView*)getCardExpiryView{
    UIView *background = [[UIView alloc]init];
    //background.backgroundColor = [UIColor blueColor];
    
    UILabel *expiryLbl = [[UILabel alloc]init];
    [background addSubview:expiryLbl];
    expiryLbl.text = @"Expiry" ;
    
    [expiryLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [expiryLbl autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:background withMultiplier:0.40];
    [expiryLbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [expiryLbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    cardYear = [[UITextField alloc]init];
    [background addSubview:cardYear];
    cardYear.placeholder = @"Year" ;
    
    [cardYear autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [cardYear autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:background withMultiplier:0.20];
    [cardYear autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [cardYear autoPinEdgeToSuperviewEdge:ALEdgeBottom];

    cardMonth = [[UITextField alloc]init];
    [background addSubview:cardMonth];
    cardMonth.placeholder = @"Month" ;
    [cardMonth autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:background withMultiplier:0.20];
    [cardMonth autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [cardMonth autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [cardMonth autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:cardYear withOffset:-10];
    return background;
}
-(UIView*)getCardNameView{
    UIView *background = [[UIView alloc]init];
    //background.backgroundColor = [UIColor redColor];
    cardName = [[UITextField alloc]init];
    [background addSubview:cardName];
    cardName.placeholder = @"Name as on card" ;
    
    [cardName autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [cardName autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [cardName autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [cardName autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    return background;
}
-(UIView*)saveCardOptionView{
     UIView *background = [[UIView alloc]init];
    
    UILabel *saveLbl = [[UILabel alloc]init];
    [background addSubview:saveLbl];
    saveLbl.text = @"Save this card" ;
    
    [saveLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
    [saveLbl autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:background withMultiplier:0.40];
    [saveLbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [saveLbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    UISwitch *switchBtn = [[UISwitch alloc]init];
    [background addSubview:switchBtn];

    [switchBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [switchBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:background];
    [switchBtn addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [switchBtn setOn:YES];
    isSaveCard = YES;
    return background;
}
-(void)clickSwitch:(UISwitch*)sender{
    isSaveCard = sender.on;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
