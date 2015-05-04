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
#import "TestParams.h"
#import "TextFieldValidator.h"
#import "CTSUtility.h"
#import "UIUtility.h"
#import "EnterCVVViewController.h"

#define REGEX_CARDNUMBER_LIMIT @"^.{19,19}$"
#define REGEX_CARDNUMBER @"^[0-9]*$"

#define REGEX_EXPIRYDATE_LIMIT @"^.{12,12}$"
#define REGEX_EXPIRYDATE_FORMAT @"[0-9]{2}      [0-9]{4}"

#define REGEX_CARDHOLDER_NAME @"[A-Za-z ]{3,20}"
#define REGEX_CARDHOLDER_NAME_LIMIT @"^.{3,20}$"


#define toErrorDescription(error) [error.userInfo objectForKey:NSLocalizedDescriptionKey]

@interface AddCardController () <UITextFieldDelegate, TextFieldValidatorProtocol>

@property(nonatomic,strong) TextFieldValidator *cardNumberTextField;
@property(nonatomic,strong) TextFieldValidator *cardNameTextField;
@property(nonatomic,strong) TextFieldValidator *expiryDateTextField;
@property(nonatomic,strong) UIImageView *cardSchemeImage;

@property(nonatomic,strong) UIScrollView *scrolView;

@end

@implementation AddCardController
@synthesize payWithCard;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Card";
    
    self.scrolView = [[UIScrollView alloc]init];
    [self.view addSubview:self.scrolView];
    
    [self.scrolView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.scrolView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.scrolView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.scrolView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];


    [self addBarButton];
    [self addSegmentedController];
    [self addCardViewDetails];
    [self addFooterMessages];
    
    self.scrolView.contentSize = CGSizeMake(0, self.view.bounds.size.height);

    [self initializeLayers];

}

-(void)addBarButton{
    UIBarButtonItem *item = [UIButton doneButtonWithTarget:self andSelector:@"done" withTitle:@"Done"];
    self.navigationItem.rightBarButtonItem = item ;
}


-(void)initializeLayers{
    authLayer = [[CTSAuthLayer alloc] init];
    proifleLayer = [[CTSProfileLayer alloc] init];
}

// Save the cards.
-(void)saveCards{
    if(isSaveCard){
        isSaveCard = NO;
        CTSPaymentDetailUpdate *paymentInfo = [[CTSPaymentDetailUpdate alloc] init];
        // Credit card info for card payment type.
        CTSElectronicCardUpdate *creditCard = [[CTSElectronicCardUpdate alloc] initCreditCard];
        creditCard.number = [self.cardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        creditCard.expiryDate = [self.expiryDateTextField.text stringByReplacingCharactersInRange:NSMakeRange(2, 6) withString:@"/"];
        creditCard.ownerName = self.cardNameTextField.text;
        [paymentInfo addCard:creditCard];
        
        // Configure your request here.
        [proifleLayer updatePaymentInformation:paymentInfo withCompletionHandler:^(NSError *error) {
            if(error == nil){
                [self.navigationController popViewControllerAnimated:YES];
                // Your code to handle success.
                [UIUtility toastMessageOnScreen:@" succesfully card saved "];
            }
            else {
                // Your code to handle error.
                [UIUtility toastMessageOnScreen:[NSString stringWithFormat:@" couldn't save card\n error: %@",toErrorDescription(error)]];
            }
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)done{
    if ([self.cardNumberTextField isFirstResponder]) {
        [self.cardNumberTextField resignFirstResponder];
    }else if ([self.expiryDateTextField isFirstResponder]) {
        [self.expiryDateTextField resignFirstResponder];
    }else if ([self.cardNameTextField isFirstResponder]) {
        [self.cardNameTextField resignFirstResponder];
    }

    if([self.cardNumberTextField validate] & [self.expiryDateTextField validate] & [self.cardNameTextField validate]){
        if (self.payWithCard) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                EnterCVVViewController *cvv = [[EnterCVVViewController alloc]initWithNibName:nil bundle:nil amount:@"Rs 1200"];
                [self.navigationController pushViewController:cvv animated:YES];
            });
        }else{
            [self saveCards];
        }
    }
}

-(void)addSegmentedController{
    segementBackGround = [[CardView alloc]init];
    UISegmentedControl *segementedController = [[UISegmentedControl alloc]initWithItems:@[@"Credit Card",@"Debit Card"]] ;
    [self.scrolView addSubview:segementBackGround];
    [segementBackGround addSubview:segementedController];
    
    [segementBackGround autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [segementBackGround autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [segementBackGround autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [segementBackGround autoSetDimension:ALDimensionHeight toSize:60];
    segementBackGround.backgroundColor = [UIColor whiteColor];
    
    [segementBackGround autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:self.scrolView];

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
    [self.scrolView addSubview:cardDetailView];
    
    [cardDetailView autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:self.scrolView];

    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [cardDetailView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [cardDetailView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:segementBackGround withOffset:30];
    [cardDetailView autoSetDimension:ALDimensionHeight toSize:(55+1+2)*4];

    cardDetailView.backgroundColor = [UIColor whiteColor];
}

-(void)addFooterMessages{
    
    UILabel *footerlbl = [[UILabel alloc]init];
    footerlbl.text = @"Save this card and you won't have to enter these details again!";
    footerlbl.numberOfLines = 0;
    footerlbl.font = [UIFont customBoldFontWithSize:14];
    footerlbl.textColor = [UIColor grayColor];
    [self.scrolView addSubview:footerlbl];
    
    [footerlbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:13];
    [footerlbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [footerlbl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cardDetailView withOffset:20];
}


-(UIView*)getVisaCardNumberView{
    UIView *background = [[UIView alloc]init];
    UIView *blocks = [self getCardNumberBlocks];
    [background addSubview:blocks];
    
    //TODO: add card image according to card number.
    self.cardSchemeImage = [[UIImageView alloc] init];
    [background addSubview:self.cardSchemeImage];
    
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
    [blocks autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12];

    [self.cardSchemeImage autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.cardSchemeImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:background];
    [self.cardSchemeImage autoSetDimension:ALDimensionHeight toSize:40];
    [self.cardSchemeImage autoSetDimension:ALDimensionWidth toSize:60];

    return background;

}

-(UIView*)getCardNumberBlocks{
    UIView *background = [[UIView alloc]init];
    self.cardNumberTextField = [[TextFieldValidator alloc] init];
    self.cardNumberTextField.delegate = self;
    self.cardNumberTextField.delegateTextFieldValidator = self;
    self.cardNumberTextField.tag = 1;
    self.cardNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.cardNumberTextField.returnKeyType = UIReturnKeyNext;
    self.cardNumberTextField.borderStyle = UITextBorderStyleNone;
    self.cardNumberTextField.presentInView = self.view;
    [background addSubview:self.cardNumberTextField];
    self.cardNumberTextField.placeholder = @"Card Number" ;
    
    [self.cardNumberTextField addRegx:REGEX_CARDNUMBER_LIMIT withMsg:@"Card number charaters limit should be come 16 digits."];
    
    [self.cardNumberTextField autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:background withMultiplier:0.80];
    [self.cardNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.cardNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.cardNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    return background;
}

-(UIView*)getCardExpiryView{
    UIView *background = [[UIView alloc]init];
    
    UILabel *expiryLbl = [[UILabel alloc]init];
    [background addSubview:expiryLbl];
    expiryLbl.text = @"Expiry" ;
    
    [expiryLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:13];
    [expiryLbl autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:background withMultiplier:0.40];
    [expiryLbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [expiryLbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    
    self.expiryDateTextField = [[TextFieldValidator alloc]init];
//    self.expiryDateTextField.backgroundColor = [UIColor blueColor];
    self.expiryDateTextField.delegate = self;
    self.expiryDateTextField.tag = 2;
    self.expiryDateTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.expiryDateTextField.returnKeyType = UIReturnKeyNext;
    self.expiryDateTextField.borderStyle = UITextBorderStyleNone;
    self.expiryDateTextField.presentInView = self.view;
    [background addSubview:self.expiryDateTextField];
    self.expiryDateTextField.placeholder = @"Month      Year" ;
    
    [self.expiryDateTextField addRegx:REGEX_EXPIRYDATE_LIMIT withMsg:@"Expiry date charaters limit should be mm yyyy format"];
    [self.expiryDateTextField addRegx:REGEX_EXPIRYDATE_FORMAT withMsg:@"Expiry date must be in proper format (eg. (mm yyyy)."];

    
    [self.expiryDateTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.expiryDateTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:background];
    [self.expiryDateTextField autoConstrainAttribute:ALAttributeWidth toAttribute:ALAttributeWidth ofView:background withMultiplier:0.45];
    [self.expiryDateTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.expiryDateTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    return background;
}

-(UIView*)getCardNameView{
    UIView *background = [[UIView alloc]init];
    self.cardNameTextField = [[TextFieldValidator alloc] init];
    self.cardNameTextField.delegate = self;
    self.cardNameTextField.tag = 3;
    self.cardNameTextField.presentInView = self.view;
    self.cardNameTextField.returnKeyType = UIReturnKeyDone;
    [background addSubview:self.cardNameTextField];
    self.cardNameTextField.placeholder = @"Name as on card" ;
    
    [self.cardNameTextField addRegx:REGEX_CARDHOLDER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-20 digits"];
    [self.cardNameTextField addRegx:REGEX_CARDHOLDER_NAME withMsg:@"Only alphabetical characters are allowed."];

    [self.cardNameTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.cardNameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:13];
    [self.cardNameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.cardNameTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    return background;
}

-(UIView*)saveCardOptionView{
     UIView *background = [[UIView alloc]init];
    
    UILabel *saveLbl = [[UILabel alloc]init];
    [background addSubview:saveLbl];
    saveLbl.text = @"Save this card" ;
    
    [saveLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:13];
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
    if([sender isOn]){
        // Execute any code when the switch is ON
        NSLog(@"Switch is ON");
        isSaveCard = YES;
    } else{
        // Execute any code when the switch is OFF
        NSLog(@"Switch is OFF");
        isSaveCard = NO;
    }
}


#pragma mark - UITextField delegates

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        
        [self done];
    }
    
    return YES;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self.scrolView setContentOffset:CGPointMake(0, 50) animated:YES];
//}


#pragma mark - TextFieldValidatorProtocol delegates

- (UIImage*)getSchmeTypeImage:(UIImage*)image{
    return self.cardSchemeImage.image = image;
}


- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)deregisterFromKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}



- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}


- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect visibleRect = self.view.frame;
    visibleRect.size.height -= keyboardSize.height;
    [self.scrolView setContentOffset:CGPointMake(0, 100) animated:YES];
}



- (void)keyboardWillBeHidden:(NSNotification *)notification {
    [self.scrolView setContentOffset:CGPointZero animated:YES];
}

@end
