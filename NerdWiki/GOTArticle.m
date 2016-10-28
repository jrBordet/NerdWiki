//
//  GOTArticle.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticle.h"

@interface GOTArticle ()

@end

@implementation GOTArticle

- (id)initWithTitle:(NSString *)t basepath:(NSString *)basePath url:(NSString *)url abstract:(NSString *)abstract thumbnail:(NSString *)thumbnail {
    
    self = [super init];
    
    if (self) {
        _key = [[[NSUUID alloc]init]UUIDString];
        
        _title = t;
        _basepath = basePath;
        _url = url;
        _abstract = abstract;
        _thumbnail = thumbnail;
    }
    
    return self;
}

- (id)init {
    return [self initWithTitle:@"Season 6"
                      basepath:@"http://gameofthrones.wikia.com"
                           url:@"/wiki/Season_6"
                      abstract:@"Season 6 of Game of Thrones was formally commissioned by HBO on 8 April 2014, following a..."
                     thumbnail:@"http://vignette2.wikia.nocookie.net/gameofthrones/images/e/e5/1508_promo_stills_12001692731.jpg/revision/latest/window-crop/width/200/x-offset/818/y-offset/0/window-width/2101/window-height/2100?cb=20150601040408"];
}

/**
 *  According to the API the article url is composed by: basepath + url
 *
 *  @return http://gameofthrones.wikia.com/wiki/Daenerys_Targaryen
 */
- (NSURL *)articleUrl {
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",self.basepath, self.url];
    NSURL *url = [[NSURL alloc] initWithString: sUrl];
    
    return url;
}

@end
