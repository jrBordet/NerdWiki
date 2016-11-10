//
//  WikiViewModel.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WikiServiceProtocol.h"

@interface WikiViewModel : NSObject

- (RACSignal *)executeSignal;

- (instancetype)initWithService:(id<WikiServiceProtocol>)service;

@end
