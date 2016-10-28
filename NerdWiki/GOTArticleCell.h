//
//  GOTArticleCell.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 10/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRReactiveView.h"

@interface GOTArticleCell : UITableViewCell <JRReactiveView>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end
