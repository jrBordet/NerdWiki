//
//  WikiArticleDetailProtocol.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 24/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WikiArticle.h"

@protocol WikiArticleDetailProtocol <NSObject>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *wordmark;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) BOOL favorite;

- (id)initWithObject:(WikiArticle *)object;

@end
