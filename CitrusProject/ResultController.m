//
//  ResultController.m
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import "ResultController.h"
#import "CardView.h"

@interface ResultController ()

@end

@implementation ResultController
@synthesize resultIdValueLbl,messageValueLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
          isSuccessFul:(BOOL)isSuccessFul{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (isSuccessFul) {
            self.title = @"All Done" ;
        }
        else{
             self.title = @"Error" ;
        }
        [self addResultView:isSuccessFul];
        [self addFooterView:isSuccessFul];
        [self addBarButton];
    }
    return self;
}
-(void)addBarButton{
    UIBarButtonItem *item = [UIButton doneButtonWithTarget:self andSelector:@"done" withTitle:@"Done"];
    self.navigationItem.rightBarButtonItem = item ;
}
-(void)done{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addResultView:(BOOL)isSuccessful{
    NSArray *displayTextsArray = [self getDisplayTextsArrayForResultType:isSuccessful];
    CardView *backGround = [[CardView alloc]init];
    [self.view addSubview:backGround];
    
    [backGround autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [backGround autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [backGround autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [backGround autoSetDimension:ALDimensionHeight toSize:250];
    
    UIImage *resultImage = [UIImage imageNamed:[displayTextsArray objectAtIndex:0]] ;
    
    UIImageView *resultImageView = [[UIImageView alloc]initWithImage:resultImage];
    [backGround addSubview:resultImageView];
    
    [resultImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [resultImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:backGround];
    
    UILabel *resultHeading = [[UILabel alloc]init];
    [backGround addSubview:resultHeading];
    resultHeading.text = [displayTextsArray objectAtIndex:1] ;
    resultHeading.textAlignment = NSTextAlignmentCenter;
    
    [resultHeading autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [resultHeading autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [resultHeading autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:resultImageView withOffset:10];
    
    UILabel *resultIdLbl = [[UILabel alloc]init];
    [backGround addSubview:resultIdLbl];
    resultIdLbl.text = [displayTextsArray objectAtIndex:2] ;
    resultIdLbl.font = [UIFont customLightFontWithSize:14];
    resultIdLbl.textAlignment = NSTextAlignmentCenter;
    
    [resultIdLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [resultIdLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [resultIdLbl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:resultHeading withOffset:20];
    
    resultIdValueLbl = [[UILabel alloc]init];
    [backGround addSubview:resultIdValueLbl];
    //resultIdValueLbl.text = @"1122552256" ;
    resultIdValueLbl.textAlignment = NSTextAlignmentCenter;
    
    [resultIdValueLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [resultIdValueLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [resultIdValueLbl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:resultIdLbl withOffset:2];
    
    
    UILabel *messageLbl = [[UILabel alloc]init];
    [backGround addSubview:messageLbl];
    messageLbl.text = [displayTextsArray objectAtIndex:3] ;
    messageLbl.font = [UIFont customLightFontWithSize:14];
    messageLbl.textAlignment = NSTextAlignmentCenter;
    
    [messageLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [messageLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [messageLbl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:resultIdValueLbl withOffset:20];
    
    messageValueLbl = [[UILabel alloc]init];
    [backGround addSubview:messageValueLbl];
    //messageValueLbl.text = @"Couldn't reach to the server" ;
    messageValueLbl.textAlignment = NSTextAlignmentCenter;
    
    [messageValueLbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [messageValueLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [messageValueLbl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:messageLbl withOffset:2];
    //[messageValueLbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}
-(void)addFooterView:(BOOL)isSuccessFul{
    if (isSuccessFul) {
        UILabel *footerlbl = [[UILabel alloc]init];
        footerlbl.text = @" Thanks! We'd love to see you again :)";
        footerlbl.numberOfLines = 0;
        footerlbl.font = [UIFont customLightFontWithSize:14];
        footerlbl.textColor = [UIColor grayColor];
        [self.view addSubview:footerlbl];
        footerlbl.textAlignment = NSTextAlignmentCenter ;
        
        [footerlbl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [footerlbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        [footerlbl autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    }
    else{
        //remaining to show action sheet
       
    }
}
-(NSArray*)getDisplayTextsArrayForResultType:(BOOL)isSuccessful{
    if(isSuccessful){
        return @[@"Check",@"Payment Successful!",@"TRANSACTION ID",@"AMOUNT PAID"];
    }
    return @[@"Cross",@"Payment Failed",@"Error ID",@"Error Message"];
}
@end
