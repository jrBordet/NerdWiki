//
//  GOTArticleProtocol.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 10/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
@import Foundation;

@protocol GOTArticleProtocol <NSObject>

- (RACSignal *)gotArticleSearchSignal:(NSString *)searchString;

@end
