//
//  CTSOauthManager.h
//  CTS iOS Sdk
//
//  Created by Yadnesh Wankhede on 21/07/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSOauthTokenRes.h"
#import "OauthStatus.h"

@protocol OauthHandler<NSObject>

@end

@interface CTSOauthManager : NSObject
+ (NSString*)readOauthToken;
+ (void)resetOauthData;
+ (BOOL)hasOauthExpired;
+ (void)saveOauthData:(CTSOauthTokenRes*)object;
+ (CTSOauthTokenRes*)readOauthData;
/**
 *  read oauthToken with expiry check,nil in case of expiry
 *
 *  @return OauthToken or nil if expired
 */
+ (NSString*)readOauthTokenWithExpiryCheck;

/**
 *  whenever access token error is reported merchant should call this method to
 * get new token from server.
 */
+ (NSString*)readRefreshToken;

/**
 *  fetch oauth token
 *
 *  @return OauthStatus with proper error and valid oauth token
 */
+ (OauthStatus*)fetchSigninTokenStatus;

+ (OauthStatus*)fetchSignupTokenStatus;

+ (void)saveSignupToken:(NSString*)token;

+ (NSString*)readSignupToken;

+ (CTSOauthTokenRes*)readBindSignInOauthData;

+(void)saveBindSignInOauth:(CTSOauthTokenRes*)object;

+ (OauthStatus*)fetchBindSigninTokenStatus;

+ (void)resetBindSiginOauthData ;

@end
