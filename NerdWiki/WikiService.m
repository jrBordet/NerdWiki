//
//  WikiService.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiService.h"
#import "JRRxHttpClient.h"
#import "GOTArticle.h"
#import "WikiArticle.h"

@implementation WikiService {
    NSString *_baseUrl;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseUrl = @"http://www.wikia.com/api/v1/Wikis/List?expand=1&lang=en&batch=1";
    }
    return self;
}

- (RACSignal *)fetchTopWikies {
    return [[JRRxHttpClient sharedClient] performRequestWithBaseUrl:_baseUrl query:nil transform:^id(NSDictionary *jsonResponse) {
        __block NSMutableArray *result = [NSMutableArray new];
        
        [[jsonResponse objectForKey:@"items"] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            [result addObject:[[WikiArticle alloc] initWithTitle:object[@"title"]
                                                             url:object[@"url"]
                                                        wordmark:object[@"wordmark"]
                                                            desc:object[@"desc"]]];
        }];
        
        return result;
    }];
}

@end
