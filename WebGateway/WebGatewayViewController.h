//
//  WebGatewayViewController.h
//  CitrusProject
//
//  Created by Mukesh Patil on 27/04/15.
//  Copyright (c) 2015 Nirma Garg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CitrusSdk.h"

@interface WebGatewayViewController : BaseViewController<UIWebViewDelegate>{
    UIWebView *webview;
}

@end
