//
//  EnterCVVViewController.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 06/04/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "EnterCVVViewController.h"
#import "ResultController.h"

@interface EnterCVVViewController ()

@end

@implementation EnterCVVViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil amount:(NSString*)amount{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addRightBarButtonWithText:amount];
    }
    return self ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCardBackGround];
    [self addCitrusLogo];
    [self addCardNumber];
    [self addCardName];
    [self addCardValidThru];
    [self addFooter];
    [self addCVVNumberField];
    [self addRadioBtns];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addRightBarButtonWithText:(NSString*)amount{
    UIBarButtonItem *item = [UIButton doneButtonWithTarget:self andSelector:nil withTitle:amount];
    self.navigationItem.rightBarButtonItem = item ;
}
-(void)addCardBackGround{
    UIImage *imageName = [UIImage imageNamed:@"CardBackground"];
    cardBackGround = [[UIImageView alloc]initWithImage:imageName];
    [self.view addSubview:cardBackGround];
    
    [cardBackGround  autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [cardBackGround autoAlignAxisToSuperviewAxis:ALAxisVertical];
}
-(void)addCitrusLogo{
    UIImage *imageName = [UIImage imageNamed:@"logo"];
    citrusLogo = [[UIImageView alloc]initWithImage:imageName];
    [cardBackGround addSubview:citrusLogo];
    
    [citrusLogo  autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [citrusLogo  autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
}
-(void)addCardNumber{
    cardNumber = [[UILabel alloc]init];
    [cardBackGround addSubview:cardNumber];
    cardNumber.text = @"XXXX  XXXX  XXXX  4444" ;
    cardNumber.textColor = [UIColor whiteColor];
    cardNumber.font = [UIFont fontWithName:CARD_FONT_NAME size:16];
    [cardNumber  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:citrusLogo withOffset:30];
    [cardNumber  autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:12];
    [cardNumber  autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:12];
}
-(void)addCardName{
    cardName = [self getViewWithHeading:@"CARD HOLDER" detail:@"YADNESH WANKHEDE"];
    [cardBackGround addSubview:cardName];
    [cardName  autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [cardName  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cardNumber withOffset:30];
}
-(void)addCardValidThru{
    cardValidThru = [self getViewWithHeading:@"VALID THRU" detail:@"09/15"];
    [cardBackGround addSubview:cardValidThru];
    [cardValidThru  autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [cardValidThru  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cardNumber withOffset:30];
    
}
-(void)addFooter{
    footerLbl = [[UILabel alloc]init];
    
    [self.view addSubview:footerLbl];
    footerLbl.text = @"ENTER CVV" ;
    footerLbl.textAlignment = NSTextAlignmentCenter ;
    [footerLbl  autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [footerLbl  autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [footerLbl autoSetDimension:ALDimensionHeight toSize:40];
     //footerLbl.backgroundColor = [UIColor blueColor];
    [footerLbl  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cardBackGround withOffset:10];
}
-(void)addCVVNumberField{
    cvvNumber = [[UITextField alloc]init];
    [self.view addSubview:cvvNumber];
    cvvNumber.keyboardType = UIKeyboardTypeNumberPad;
    cvvNumber.delegate = self;
    cvvNumber.textColor = [UIColor clearColor];
    cvvNumber.tintColor = [UIColor clearColor] ;
    [cvvNumber  autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [cvvNumber  autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [cvvNumber  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:footerLbl withOffset:20];
    [cvvNumber becomeFirstResponder];
}
-(void)addRadioBtns{
    UIView *radioBtnBackGround = [[UIView alloc]init];//
    cvvStringEntered = @"";
    radioBtns = [[NSMutableArray alloc]init];
     UIImage *img = [UIImage imageNamed:@"Icon-CVV"];
    for (int i = 0; i<3; i++) {
       UIImageView *cvvRadio = [[UIImageView alloc]initWithImage:img];
        [radioBtnBackGround addSubview:cvvRadio];;
        [cvvRadio autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [radioBtns addObject:cvvRadio];
        if (i==0) {
            [cvvRadio autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        }
        else{
            UIImageView *previousRadio = [radioBtns objectAtIndex:i-1];
            [cvvRadio autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:previousRadio withOffset:10];
        }
    }
    [self.view addSubview:radioBtnBackGround];
    //radioBtnBackGround.backgroundColor = [UIColor redColor];
    [radioBtnBackGround  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:footerLbl];
    [radioBtnBackGround autoSetDimensionsToSize:CGSizeMake((img.size.width)*3+(10*2), img.size.height)];
    [radioBtnBackGround autoAlignAxisToSuperviewAxis:ALAxisVertical];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    int textPos = range.location ;
    NSLog(@" range %d",textPos);
    [self setRadioBtnForPos:textPos cvvtextLength:textField.text.length];
    if (textPos > 1) {
        cvvStringEntered = [NSString stringWithFormat:@"%@%@",textField.text,string];
        NSLog(@" cvv number entered %@",cvvStringEntered);
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(dissmissView) userInfo:nil repeats:NO];
       
    }
    return YES;
}
-(void)dissmissView{
    
    ResultController *result = [[ResultController alloc] initWithNibName:nil bundle:nil  isSuccessFul:YES];
    result.resultIdValueLbl.text = @"2323232";
    result.messageValueLbl.text = @"Rs. 1200";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:result];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
    UIViewController *View = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
    [self.navigationController popToViewController:View animated:YES];

}
-(void)setRadioBtnForPos:(int)pos cvvtextLength:(int)textLen{
    if ([self isTextEnterAtPos:pos totalTextFieldLength:textLen]) {
        [self enableRadioBtnAtPos:pos];
    }
    else{
        [self disableRadioBtnAtPos:pos];
    }
}
-(void)disableRadioBtnAtPos:(int)pos{
    UIImage *img = [UIImage imageNamed:@"Icon-CVV"];
    UIImageView *radioBtn = [radioBtns objectAtIndex:pos];
    radioBtn.image = img;
}
-(void)enableRadioBtnAtPos:(int)pos{
    UIImage *img = [UIImage imageNamed:@"Icon-CVV-Filled"];
    UIImageView *radioBtn = [radioBtns objectAtIndex:pos];
    radioBtn.image = img;
}
-(BOOL)isTextEnterAtPos:(int)textPos
   totalTextFieldLength:(int)textLength{
    if (textLength==textPos) {
        return YES;
    }
    return NO;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@" text length%d",textField.text.length);
    return YES;
}
-(UIView*)getViewWithHeading:(NSString*)headingStr
                           detail:(NSString*)detailStr{
    UIView *footerView = [[UIView alloc]init];
    
    UILabel *heading = [[UILabel alloc]init];
    heading.font = [UIFont fontWithName:CARD_FONT_NAME size:10];//[UIFont customBoldFontWithSize:8];
    [footerView addSubview:heading];
    heading.text = headingStr ;
    [heading  autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [heading  autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [heading  autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    heading.textColor = [UIColor whiteColor];
    
    UILabel *detailLbl = [[UILabel alloc]init];
    detailLbl.font = [UIFont fontWithName:CARD_FONT_NAME size:12];
    [footerView addSubview:detailLbl];
    detailLbl.text = detailStr ;
    [detailLbl  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:heading];
    [detailLbl  autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [detailLbl  autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    detailLbl.textColor = [UIColor whiteColor];
    
    return footerView;
}
@end
