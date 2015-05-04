//
//  WebGatewayViewController.m
//  CitrusProject
//
//  Created by Mukesh Patil on 27/04/15.
//  Copyright (c) 2015 Nirma Garg. All rights reserved.
//

#import "WebGatewayViewController.h"
#import "ResultController.h"

@interface WebGatewayViewController ()

@end

@implementation WebGatewayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"Processing...";
    
    webview = [[UIWebView alloc] init];
    webview.delegate = self;
    [self.view addSubview:webview];

    webview.backgroundColor = [UIColor redColor];
    
    
    [webview autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [webview autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [webview autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [webview autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    
    [self loadRedirectUrl:@"http://www.citruspay.com"];

    
    UILabel *lbl = [[UILabel alloc]init];
    lbl.backgroundColor = [UIColor lightGrayColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];
    lbl.font = [UIFont customLightFontWithSize:16];
    lbl.text = @"WEB GATEWAY" ;
    [webview addSubview:lbl];
    [lbl autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [lbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [lbl autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [lbl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}


#pragma mark - helper methods

- (void)loadRedirectUrl:(NSString*)redirectURL {
    [webview loadRequest:[[NSURLRequest alloc]
                          initWithURL:[NSURL URLWithString:redirectURL]]];
}

- (void)transactionComplete:(NSDictionary*)transactionResult {
    LogTrace(@" transactionResult %@ ",
             [transactionResult objectForKey:@"TxStatus"]);
}

#pragma mark - webview delegates

- (void)webViewDidStartLoad:(UIWebView*)webView {
}

//- (BOOL)webView:(UIWebView*)webView
//shouldStartLoadWithRequest:(NSURLRequest*)request
// navigationType:(UIWebViewNavigationType)navigationType {
//    NSDictionary* responseDict =
//    [CTSUtility getResponseIfTransactionIsFinished:request.HTTPBody];
//    if (responseDict != nil) {
//        [self transactionComplete:responseDict];
//    }
//    
//    return YES;
//}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    
    dispatch_async(dispatch_get_main_queue(), ^(){
//        ResultController *result = [[ResultController alloc] initWithNibName:nil bundle:nil  isSuccessFul:YES];
//        result.resultIdValueLbl.text = @"2323232" ;
//        result.messageValueLbl.text = @"Rs. 1200" ;
        
        
        ResultController *result = [[ResultController alloc]initWithNibName:nil bundle:nil  isSuccessFul:NO];
        result.resultIdValueLbl.text = @"1122552256" ;
        result.messageValueLbl.text = @"Couldn't reach to the server"  ;

        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:result];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
        [self.navigationController popViewControllerAnimated:NO];
    });
}


@end
