//
//  CustomTableView.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardView;
@interface CustomTableView : UIView
{
    UILabel *heading;
    CardView *view;
}
-(id)initWithHeading:(NSString*)headingName;
@end
