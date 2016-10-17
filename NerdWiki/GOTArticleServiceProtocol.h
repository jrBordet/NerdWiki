//
//  GOTArticleServiceProtocol.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JRRxHttpClient.h"

@protocol GOTArticleServiceProtocol <NSObject>

// Methods
/**
 *
 *
 *  @return a list of top Characters of GOT
 */
- (RACSignal *)fetchTopCharacters;

@end
