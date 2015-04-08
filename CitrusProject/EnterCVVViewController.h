//
//  EnterCVVViewController.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 06/04/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface EnterCVVViewController : BaseViewController<UITextFieldDelegate>{
    UIImageView *cardBackGround ;
    UIImageView *citrusLogo ;
    UILabel *cardNumber;
    UIView *cardName;
    UIView *cardValidThru ;
    UITextField *cvvNumber;
    UILabel *footerLbl;
    NSMutableArray *radioBtns;
    NSString *cvvStringEntered;
}
@property(nonatomic,strong)NSString *cardNumberLastFourLetter ;
-(id)initWithNibName:(NSString *)nibNameOrNil
              bundle:(NSBundle *)nibBundleOrNil
              amount:(NSString*)amount;

@end
