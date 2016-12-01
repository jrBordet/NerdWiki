//
//  WikiServiceProtocol.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol RxHttpClientProtocol;

@protocol WikiServiceProtocol <NSObject>

- (RACSignal *)fetchTopWikies;

@property (nonatomic, strong) NSString *serviceUrl;

@property (nonatomic, strong) id<RxHttpClientProtocol> sharedClient;

@end
