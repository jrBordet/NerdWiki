//
//  GOTArticleService.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GOTArticleServiceProtocol.h"

@protocol RxHttpClientProtocol;

@interface GOTArticleService : NSObject <GOTArticleServiceProtocol>

@property (nonatomic, strong) id<RxHttpClientProtocol> rxSharedClient;
@property (nonatomic, strong) NSString *test;

@end
