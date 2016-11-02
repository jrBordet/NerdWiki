//
//  GOTArticleDetailViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticleDetailViewController.h"

@interface GOTArticleDetailViewController ()

@property (nonatomic, strong) GOTArticle *article;

@end

@implementation GOTArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.articleWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.article.url]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithArticle:(GOTArticle *)article {
    self = [super init];
    if (self) {
        _article = article;
    }
    return self;
}

@end
