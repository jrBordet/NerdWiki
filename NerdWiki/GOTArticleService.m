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
#import "GOTArticle.h"

@interface GOTArticleService ()

@property (nonatomic, strong) NSMutableSet *requests;

@end

@implementation GOTArticleService

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _requests = [NSMutableSet new];
    }
    
    return self;
}

- (RACSignal *)fetchTopCharacters {
    NSDictionary *queryString = @ {
        @"expand": @"1",
        @"Category": @"Characters",
        @"limit": @"1000"
    };
    
    return [[JRRxHttpClient sharedClient] performRequestWithBaseUrl:@"http://gameofthrones.wikia.com/api/v1/Articles/Top" query:queryString transform:^id(NSDictionary *jsonResponse) {
        __block NSMutableArray *result = [NSMutableArray new];
        
        [[jsonResponse objectForKey:@"items"] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            [result addObject:[[GOTArticle alloc]initWithTitle:object[@"title"]
                                                      Basepath:jsonResponse[@"basepath"]
                                                           Url:object[@"url"]
                                                      Abstract:object[@"abstract"]
                                                     Thumbnail:object[@"thumbnail"]]];
            
        }];
        
        return result;
    }];
}

@end

