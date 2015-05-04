//
//  ResultController.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@protocol ResultControllerProtocol

@optional
- (void)retryTransction;
@end

@class CardView;

@interface ResultController : BaseViewController{
    CardView *cardDetailView;
    
}

@property (nonatomic,retain) id<ResultControllerProtocol> delegate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
        isSuccessFul:(BOOL)isSuccessFul;
@property(nonatomic,strong) UILabel *resultIdValueLbl;
@property(nonatomic,strong) UILabel *messageValueLbl ; 
@end
