//
//  WikiArticle.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WikiArticle : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *wordmark;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) BOOL favorite;

- (id)initWithTitle:(NSString *)title
             domain:(NSString *)domain
                url:(NSString *)url
           wordmark:(NSString *)wordmark
               desc:(NSString *)desc;

- (id)initWithObject:(id)object;

+ (NSArray *)parseWikiArticlesWithJSONResponse:(NSDictionary *)jsonResponse;
+ (NSArray *)parseUrlDetailsWithWikiArticles:(NSArray *)wikiArticles;

@end
