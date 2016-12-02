//
//  WikiService.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiService.h"
#import "JRRxHttpClient.h"
#import "WikiArticle.h"

@implementation WikiService

@synthesize sharedClient, serviceUrl;

- (RACSignal *)fetchTopWikies {
    return [self.sharedClient performRequestWithBaseUrl:self.serviceUrl query:nil transform:^id(NSDictionary *jsonResponse) {
        __block NSMutableArray *result = [NSMutableArray new];
        
        [[jsonResponse objectForKey:@"items"] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            [result addObject:[[WikiArticle alloc] initWithTitle:object[@"title"]
                                                          domain:object[@"domain"]
                                                             url:object[@"url"]
                                                        wordmark:object[@"wordmark"]
                                                            desc:object[@"desc"]]];
        }];
        
        return result;
    }];
}

@end
