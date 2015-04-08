//
//  AddCardController.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class CardView ; 
@interface AddCardController : BaseViewController{
    CardView *segementBackGround ;
    CardView *cardDetailView ; 
    
    UITextField *cardNumber;
    UITextField *cardMonth;
    UITextField *cardYear;
    UITextField *cardName;
    
    NSMutableArray *cardNumberBlocks;
    
    BOOL isSaveCard ; 
}

@end
