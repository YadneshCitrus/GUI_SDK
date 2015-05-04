//
//  HomeViewController.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CitrusCashView.h"
#import "CustomTableView.h"
#import "ResultController.h"


@interface HomeViewController : BaseViewController <CitrusCashViewProtocol, CustomTableViewProtocol, ResultControllerProtocol>{
    UILabel *balanceLbl;
    BOOL isShowBalance;
}

@end
