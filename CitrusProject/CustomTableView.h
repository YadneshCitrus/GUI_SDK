//
//  CustomTableView.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTableViewProtocol

@optional
/**
 @brief     ----------
 @details   ----------
 */
- (void)addCard;

/**
 @brief     ----------
 @details   ----------
 */
- (void)payWithSavedCards;

/**
 @brief     ----------
 @details   ----------
 */
- (void)payWithCreditDebitCard;


/**
 @brief     ----------
 @details   ----------
 */
- (void)payWithNetBanking;

/**
 @brief     ----------
 @details   ----------
 */
- (void)getPayWithOtherNBsViewController;
@end

@class CardView;
@interface CustomTableView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    UILabel *heading;
    CardView *view;
    CardView *cardDetailView;
}
@property (nonatomic,retain) id<CustomTableViewProtocol> delegate;

-(id)initWithHeading:(NSString*)headingName;
@end
