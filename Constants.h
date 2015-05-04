//
//  Constants.h
//  CitrusProject
//
//  Created by Yadnesh Wankhede on 30/03/15.
//  Copyright (c) 2015 Yadnesh Wankhede. All rights reserved.
//

#ifndef CitrusProject_Constants_h
#define CitrusProject_Constants_h

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BackGroundColor [UIColor colorWithRed:230.0/255.0 green:229.0/255.0 blue:227.0/255.0 alpha:1.0]
#define ORANGE_COLOR 0xF9A323
#define BLUE_COLOR 0x37A8EB
#define RED_COLOR 0xFO5E5E
#define BLACK_COLOR 0x232323
#define GREEN_COLOR 0x77C83E
#define GRAY_COLOR 0x414A5A

#define DEBIT_CREDIT_CARD @"CREDIT/DEBIT CARD"
#define SAVE_CARD @"SAVED CARDS"
#define NET_BANKING @"NET BANKING"

#define CARD_FONT_NAME  @"OCRAExtended"
#endif
