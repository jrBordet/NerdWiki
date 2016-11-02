//
//  UIImageView+Geometry.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "UIImageView+Geometry.h"

@implementation UIImageView (Geometry)

- (void)rounded {
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0;
}

@end
