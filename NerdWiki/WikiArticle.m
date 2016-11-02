//
//  WikiArticle.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiArticle.h"

@implementation WikiArticle

- (id)initWithTitle:(NSString *)title url:(NSString *)url wordmark:(NSString *)wordmark desc:(NSString *)desc {
    self = [super init];
    
    if (self) {
        _title = title;
        _url = url;
        _wordmark = wordmark;
        _desc = desc;
    }
    return self;
}

@end
