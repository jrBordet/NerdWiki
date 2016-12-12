//
//  GOTArticleServiceProtocol.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JRRxHttpClient.h"

@protocol ArticleServiceProtocol <NSObject>

- (RACSignal *)fetchTopCharactersWithRequest:(NSString *)request;

@property (nonatomic, strong) NSString *serviceUrl;
@property (nonatomic, strong) id<RxHttpClientProtocol> sharedClient;

@end
