//
//  WikiArticleDetail.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 10/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiArticleDetail.h"

@implementation WikiArticleDetail

@synthesize name, domain, url, wordmark, desc, favorite;

- (id)initWithObject:(WikiArticle *)object {
    self = [super init];
    
    if (self) {
        name = object.title;
        domain = object.domain;
        url = object.url;
        wordmark = object.wordmark;
        desc = object.desc;
    }
    
    return self;
}

@end
