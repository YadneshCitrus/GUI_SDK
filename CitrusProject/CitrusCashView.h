//
//  CitrusCashView.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitrusCashViewProtocol

@optional
/**
 @brief                 Make payment with Citrus pay.
 @details               Using this method user can pay money from Citrus Pay account for any online transcton.
 */
- (void)payNowWithCitrusCash;

/**
 @brief                 Add Money into Citrus pay account.
 @details               Using this method user can add money into Citrus Pay account.
 */
- (void)addMoneyAndPayNowWithCitrusCash;
@end

@class CardView;

@interface CitrusCashView : UIView{
    UILabel *heading;
    CardView *view;
    UILabel *balanceLbl;
}
@property (nonatomic,retain) id<CitrusCashViewProtocol> delegate;

@end
