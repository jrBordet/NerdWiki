//
//  JRRxHttpClient.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 20/09/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa/RACEXTScope.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JRHttpClientDelegate.h"

@protocol RxHttpClientProtocol <NSObject>

// Singleton
+ (instancetype)sharedClient;

// Utility methods
- (RACSignal *)performRequestWithBaseUrl:(NSString *)baseUrl
                                   query:(NSDictionary *)query
                               transform:(id (^)(NSDictionary *jsonResponse))response;

// Properties

@end

@interface JRRxHttpClient : NSObject <RxHttpClientProtocol, JRHttpClientDelegate>

//- (RACSignal *)performRequestWithBaseUrl:(NSString *)baseUrl query:(NSDictionary *)query transform:(id (^)(NSDictionary *jsonResponse))response;

@end
