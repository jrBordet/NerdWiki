//
//  WikiCell.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRReactiveView.h"

@interface WikiCell : UITableViewCell <JRReactiveView>

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end
