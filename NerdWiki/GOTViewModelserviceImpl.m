//
//  GOTViewModelserviceImpl.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 18/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTViewModelserviceImpl.h"
#import "GOTSeacrhImpl.h"

@interface GOTViewModelserviceImpl ()

@property (nonatomic, strong) GOTSeacrhImpl *searchService;

@end

@implementation GOTViewModelserviceImpl

- (instancetype)init {
    if (self = [super init]) {
        _searchService = [GOTSeacrhImpl new];
    }
    return self;
}

- (id<GOTSearch>)getGotSearchService {
    return self.searchService;
}

@end
