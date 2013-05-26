//
//  EvernoteOAuth.h
//  OAuthTestRb
//
//  Created by AirMyac on 5/26/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAToken.h"
#import "OAConsumer.h"
#import "OADataFetcher.h"
#import "OAServiceTicket.h"

@protocol EvernoteDelegate
- (void) oAuthTokenReceived:(OAToken*) token;
- (void) oAuthAccessTokenReceived:(OAToken*) token;
- (void) oAuthFailed;
@end

@interface EvernoteOAuth : NSObject
{
@private
    NSString* consumerKey;
    NSString* consumerSecret;
    
    id<TwitterDelegate> del;
    OAToken* requestToken;
    NSMutableData* responseData;
}

- (EvernoteOAuth*) initWithKey:(NSString*) key withSecret:(NSString*) secret;
- (void) setDelegate:(id<EvernoteDelegate>) delegate;
- (void) getOAuthToken;
- (void) requestOAuthAccessToken:(NSURLRequest*) request;
@end

@end
