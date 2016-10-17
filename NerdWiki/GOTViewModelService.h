//
//  GOTViewModelService.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 17/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GOTSearch.h"

@protocol GOTViewModelService <NSObject>

- (id<GOTSearch>)getGotSearchService;

@end
