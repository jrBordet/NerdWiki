//
//  WikiArticle.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiArticle.h"

@implementation WikiArticle

- (id)initWithTitle:(NSString *)title  domain:(NSString *)domain url:(NSString *)url wordmark:(NSString *)wordmark desc:(NSString *)desc {
    self = [super init];
    
    if (self) {
        _title = title;
        _domain = domain;
        _url = url;
        _wordmark = wordmark;
        _desc = desc;
    }
    return self;
}

- (id)initWithObject:(id)object {
    self = [super init];
    if (self) {
        self = [self initWithTitle:object[@"title"]
                            domain:object[@"domain"]
                               url:object[@"url"]
                          wordmark:object[@"wordmark"]
                              desc:object[@"desc"]];
    }
    return self;
}

+ (NSArray *)parseWikiArticlesWithJSONResponse:(NSDictionary *)jsonResponse {
    NSMutableArray *result = [NSMutableArray new];
    
    [[jsonResponse objectForKey:@"items"] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        [result addObject:[[WikiArticle alloc] initWithObject:object]];
    }];
    
    return result;
}

+ (NSArray *)parseUrlDetailsWithWikiArticles:(NSArray *)wikiArticles {
    NSMutableArray *result = [NSMutableArray new];
        
    [wikiArticles enumerateObjectsUsingBlock:^(WikiArticle *obj, NSUInteger idx, BOOL *stop) {
        [result addObject:[NSString stringWithFormat:@"http://%@/api/v1/Articles/List?expand=1&limit=100", obj.domain]];
    }];
    
    return result;
}

@end
