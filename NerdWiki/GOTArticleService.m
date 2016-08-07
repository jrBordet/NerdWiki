//
//  GOTArticleService.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticleService.h"
#import "JRHttpClientDelegate.h"
#import "JRHttpClient.h"
#import "ReactiveCocoa/RACEXTScope.h"

@interface GOTArticleService ()

@property (nonatomic, strong) NSMutableSet *requests;

@end

@implementation GOTArticleService

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _requests = [NSMutableSet new];
        // ciaoo
    }
    
    return self;
}


- (RACSignal *)fetchTopArticles {
    return [self performRequestWithQuery:nil transform:^id(NSDictionary *jsonResponse) {
        NSLog(@"%@", jsonResponse);
        for (id object in jsonResponse) {
            NSLog(@"%@", object);
        }
        return nil;
    }];
}

- (RACSignal *)performRequestWithQuery:(NSDictionary *)query transform:(id (^)(NSDictionary *response))jsonResponse {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [[JRHttpClient sharedClient] setDelegate:self];
        
        RACSignal *successSignal = [self rac_signalForSelector:@selector(downloadCompletedWith:)
                                                  fromProtocol:@protocol(JRHttpClientDelegate)];
        
        [[[successSignal map:^id(RACTuple *value) {
            return value.first;
        }] map:jsonResponse]
         subscribeNext:^(id x) {
             [subscriber sendNext:x];
             [subscriber sendCompleted];
         }];
        
        [[JRHttpClient sharedClient] performRequestWith:@"http://gameofthrones.wikia.com/api/v1/Articles/Top"
                                                  query:query];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

@end

