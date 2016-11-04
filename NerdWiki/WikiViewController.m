//
//  WikiViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiViewController.h"
#import "JRCollectionViewBinding.h"
#import "GOTArticle.h"

@interface WikiViewController ()

@property (nonatomic, strong) JRCollectionViewBinding *binding;
@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation WikiViewController {
    UICollectionView *_collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _searchResults = [NSMutableArray new];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UICollectionViewFlowLayout *layout= [UICollectionViewFlowLayout new];
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(200, 200)];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                         collectionViewLayout:layout];
    
    for (int i=0; i < 100; i++) {
        GOTArticle *article = [[GOTArticle alloc] initWithTitle:[NSString stringWithFormat:@"title %i", i]
                                                       basepath:@""
                                                            url:@"http://vignette1.wikia.nocookie.net/wikiaglobal/images/3/35/Wikia-Visualization-Main%2Cfallout.png/revision/latest?cb=20140529125056"
                                                       abstract:@""
                                                      thumbnail:@""];
        [self.searchResults addObject:article];
    }
    
    UINib *nib = [UINib nibWithNibName:@"WikiCell" bundle:nil];
    
    self.binding = [JRCollectionViewBinding bindingHelperForCollectionView:_collectionView
                                                                     frame:self.view.frame
                                                              sourceSignal:RACObserve(self, searchResults)
                                                          selectionCommand:nil
                                                              templateCell:nib
                                                           scrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_collectionView];
}

@end
