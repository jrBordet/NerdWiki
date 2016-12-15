//
//  WikiArticleDetailViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiArticleDetailViewController.h"
#import "JRRxHttpClient.h"
#import "ArticleViewController.h"
#import "NWApplicationAssembly.h"

@interface WikiArticleDetailViewController ()

@property (nonatomic, strong) WikiArticleDetail *articleDetail;

@end

@implementation WikiArticleDetailViewController {
    NWApplicationAssembly *_assembly;
}

- (instancetype)initWitArticleDetail:(WikiArticleDetail *)articleDetail assembly:(NWApplicationAssembly *)assembly {
    self = [super init];
    
    if (self) {
        _articleDetail = articleDetail;
        _assembly = assembly;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = _articleDetail.name;
    self.navigationController.navigationBar.barTintColor = self.backgroundColor;
    self.navigationController.navigationBar.tintColor = self.navigationItemColor;
    
    self.view.backgroundColor = self.backgroundColor;
    
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithTitle:@"Characters"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(openArticleList)];
    
    listButton.tintColor = self.navigationItemColor;
    
    self.navigationItem.rightBarButtonItem = listButton;
    
    [[self.sharedClient fetchImageFromUrl:[NSURL URLWithString:self.articleDetail.wordmark] placheholderImage:self.wordmarkImage] subscribeCompleted:^{
    }];
    
    self.descLabel.text = self.articleDetail.desc;
}

- (void)openArticleList {
    // @"http://gameofthrones.wikia.com/api/v1/Articles/Top"
    NSString *request = [NSString stringWithFormat:@"http://%@/api/v1/Articles/Top", _articleDetail.domain];
    
    ArticleViewController *list = [_assembly articleViewControllerWithArticleRequest:request];
    
    [self.navigationController pushViewController:list
                                         animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
