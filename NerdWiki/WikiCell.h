//
//  WikiCell.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBReactiveView.h"

@interface WikiCell : UITableViewCell <RBReactiveView>

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImage;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
