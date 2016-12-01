//
//  WikiViewModelProtocol.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 18/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WikiViewModelProtocol <NSObject>

- (instancetype)initWithService:(id<WikiServiceProtocol>)service;

- (RACSignal *)executeSignal;

@end
