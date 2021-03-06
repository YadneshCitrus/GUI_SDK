//
//  CTSAuthLayer.h
//  RestFulltester
//
//  Created by Yadnesh Wankhede on 23/05/14.
//  Copyright (c) 2014 Citrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSOauthTokenRes.h"
#import "RestLayerConstants.h"
#import "CTSAuthLayerConstants.h"
#import "CTSRestPluginBase.h"
#import "CTSRestCoreResponse.h"
#import "MerchantConstants.h"
#import "CTSLinkUserRes.h"

@class CTSAuthLayer;
@protocol CTSAuthenticationProtocol

/**
 *  reports sign in respose
 *
 *  @param isSuccessful  status
 *  @param userName     username that was used for signin
 *  @param token : oauth token if signin followed by signup is successful is
 *successful,nil otherwise.
 *  @param error        error,nil in case of success.
 */
@optional
- (void)auth:(CTSAuthLayer*)layer
    didSigninUsername:(NSString*)userName
           oauthToken:(NSString*)token
                error:(NSError*)error;

/**
 *  reports sign up reply
 *
 *  @param isSuccessful
 *  @param token : oauth token if signin is successful,nil otherwise
 *  @param error
 */
@optional
- (void)auth:(CTSAuthLayer*)layer
    didSignupUsername:(NSString*)userName
           oauthToken:(NSString*)token
                error:(NSError*)error;

/**
 *  reports change password reply
 *
 *  @param layer
 *  @param error
 */
@optional
- (void)auth:(CTSAuthLayer*)layer didChangePasswordError:(NSError*)error;

/**
 *  reports is user Citrus member
 *
 *  @param layer
 *  @param isMember Bool that reports membership status
 *  @param error
 */
@optional
- (void)auth:(CTSAuthLayer*)layer
    didCheckIsUserCitrusMember:(BOOL)isMember
                         error:(NSError*)error;

/**
 *  reports password reset
 *
 *  @param layer
 *  @param error
 */
@optional
- (void)auth:(CTSAuthLayer*)layer didRequestForResetPassword:(NSError*)error;



@optional
- (void)auth:(CTSAuthLayer*)layer didBindUser:(NSString*)userName error:(NSError *)error;


@optional
- (void)auth:(CTSAuthLayer*)layer didCitrusSigninInerror:(NSError *)error;

@optional
- (void)auth:(CTSAuthLayer*)layer didLinkUser:(CTSLinkUserRes *)linkUserRes error:(NSError *)error;


@optional
- (void)auth:(CTSAuthLayer*)layer didSetPasswordError:(NSError*)error;
@end

@interface CTSAuthLayer : CTSRestPluginBase {
  int seedState;
  NSString* userNameSignIn,*passwordSignin, *userNameSignup, *passwordSignUp, *mobileSignUp;
    NSString  *userNameBind,*mobileBind;
    BOOL isInLink;

  BOOL wasSignupCalled;
}

typedef void (^ASSigninCallBack)(NSString* userName,
                                 NSString* token,
                                 NSError* error);

typedef void (^ASSignupCallBack)(NSString* userName,
                                 NSString* token,
                                 NSError* error);

typedef void (^ASChangePassword)(NSError* error);

typedef void (^ASSetPassword)(NSError* error);


typedef void (^ASIsUserCitrusMemberCallback)(BOOL isUserCitrusMember,
                                             NSError* error);

typedef void (^ASResetPasswordCallback)(NSError* error);

typedef void (^ASBindUserCallback)(NSString *userName,
                                   NSError* error);

typedef void (^ASCitrusSigninCallBack)(NSError* error);

typedef void (^ASLinkUserCallBack)(CTSLinkUserRes *linkUserRes, NSError* error);

@property(nonatomic, weak) id<CTSAuthenticationProtocol> delegate;



/**
 *  sign in the user
 *
 *  @param userName email adress
 *  @param password
 *  @param callBack
 */
- (void)requestSigninWithUsername:(NSString*)userName
                         password:(NSString*)password
                completionHandler:(ASSigninCallBack)callBack;

/**
 *  to sign up the user
 *
 *  @param email    this will be the username
 *  @param mobile
 *  @param password
 *  @param callBack
 */
- (void)requestSignUpWithEmail:(NSString*)email
                        mobile:(NSString*)mobile
                      password:(NSString*)password
             completionHandler:(ASSignupCallBack)callBack;

/**
 *  in case of forget password,after recieving this server will send email to
 *this user to initiate the password reset
 *
 *  @param userNameArg
 */
- (void)requestResetPassword:(NSString*)userNameArg
           completionHandler:(ASResetPasswordCallback)callBack;

/**
 *  to change the user password
 *
 *  @param userName
 *  @param oldPassword
 *  @param newPassword
 *  @param callback
 */
- (void)requestChangePasswordUserName:(NSString*)userName
                          oldPassword:(NSString*)oldPassword
                          newPassword:(NSString*)newPassword
                    completionHandler:(ASChangePassword)callback;

/**
 *  to check if username is registered for any member
 *
 *  @param email    this is the username
 *  @param callback
 */
- (void)requestIsUserCitrusMemberUsername:(NSString*)email
                        completionHandler:
                            (ASIsUserCitrusMemberCallback)callback;

- (void)requestBindUsername:(NSString*)email
                     mobile:(NSString *)mobile
                        completionHandler:
(ASBindUserCallback)callback;

-(void)requestSetPassword:(NSString *)password userName:(NSString *)userName completionHandler:(ASSetPassword)callback;

-(void)requestCitrusPaySignin:(NSString *)userName  password:(NSString*)password
            completionHandler:(ASCitrusSigninCallBack)callBack;

/**
 *  signout
 *
 *  @return YES
 */
- (BOOL)signOut;

/**
 *  to confirm if anyone is signed in
 *
 *  @return yes if anyone is signed in, NO otherwise
 */
-(BOOL)isAnyoneSignedIn;

- (NSString*)generateBigIntegerString:(NSString*)email ;


-(void)requestLinkUser:(NSString *)email mobile:(NSString *)mobile completionHandler:(ASLinkUserCallBack)callBack;

-(NSString *)requestSignInOauthToken;

@end
