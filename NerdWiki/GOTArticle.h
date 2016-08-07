//
//  GOTArticle.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOTArticle : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *basepath;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, assign) BOOL favorite;

- (id)initWithTitle: (NSString *)t Basepath: (NSString *)basePath Url: (NSString *)url Abstract: (NSString *)abstract Thumbnail: (NSString *)thumbnail;

/**
 *  Create the detail Article
 *
 *  @return an NSUrl
 */
- (NSURL *)articleUrl;

@end
