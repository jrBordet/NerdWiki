//
//  WikiArticleDetail.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 10/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiArticleDetail.h"

@implementation WikiArticleDetail

- (id)initWithName:(NSString *)name domain:(NSString *)domain url:(NSString *)url wordmark:(NSString *)wordmark desc:(NSString *)desc {
    self = [super init];
    
    if (self) {
        _name = name;
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
        self = [self initWithName:object[@"title"]
                            domain:object[@"domain"]
                               url:object[@"url"]
                          wordmark:object[@"wordmark"]
                              desc:object[@"desc"]];
    }
    return self;
}

@end
