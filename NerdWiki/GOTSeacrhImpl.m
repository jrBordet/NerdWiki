//
//  GOTSeacrhImpl.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 17/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTSeacrhImpl.h"

@implementation GOTSeacrhImpl

- (RACSignal *)gotSearchSignal:(NSString *)searchString {
    return [[[[RACSignal empty] logAll] delay:2.0] logAll];
}

@end
