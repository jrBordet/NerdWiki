//
//  JRCollectionViewBinding.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/10/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "JRCollectionViewBinding.h"
#import "JRReactiveView.h"

@interface JRCollectionViewBinding () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UICollectionViewCell *templateCell;

@end

@implementation JRCollectionViewBinding

+ (instancetype)bindingHelperForCollectionView:(UICollectionView *)collectionView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                             templateCell:(UINib *)templateCellNib {
    
    return [[JRCollectionViewBinding alloc] initWithCollectionView:collectionView
                                            sourceSignal:source
                                        selectionCommand:selection
                                            templateCell:templateCellNib];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                     sourceSignal:(RACSignal *)source
                 selectionCommand:(RACCommand *)selection
                     templateCell:(UINib *)templateCellNib {
    
    if (self = [super init]) {
        _collectionView = collectionView;
        _data = [NSArray array];
        
        [source subscribeNext:^(id x) {
            self.data = x;
            [self.collectionView reloadData];
        }];
        
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        [collectionView registerNib:templateCellNib forCellWithReuseIdentifier:_templateCell.reuseIdentifier];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(200, 200)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        [_collectionView setCollectionViewLayout:flowLayout];
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JRReactiveView> cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.templateCell.reuseIdentifier
                                                                        forIndexPath:indexPath];
    
    [cell bindViewModel:self.data[indexPath.row]];
    
    return (UICollectionViewCell *)cell;
}

@end
