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

+ (instancetype)sharedClient;

- (RACSignal *)performRequestWithBaseUrl:(NSString *)baseUrl
                                   query:(NSDictionary *)query
                               transform:(id (^)(NSDictionary *jsonResponse))response;

-(RACSignal *)fetchImageFromUrl:(NSURL *)url
              placheholderImage:(UIImageView *)placeholderImage;

@end

@interface JRRxHttpClient : NSObject <RxHttpClientProtocol, JRHttpClientDelegate>

@end
