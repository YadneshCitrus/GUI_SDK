//
//  BanksViewController.h
//  CitrusProject
//
//  Created by Mukesh Patil on 04/05/15.
//  Copyright (c) 2015 Nirma Garg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol BanksViewProtocol

@optional
/**
 @brief     ----------
 @details   ----------
 */
- (void)payWithOtherNetBanking;
@end

@interface BanksViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,retain) id<BanksViewProtocol> delegate;
@end
