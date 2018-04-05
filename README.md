# NerdWiki

NerdWiki is a simple project based on [Fandom API](http://www.wikia.com/api/v1/)

## Usage

``` 
    pod install
```


## Architecture

### App

``` objective-c

@interface NWApplicationAssembly : TyphoonAssembly

@property (nonatomic, strong) NWCoreComponents *coreComponents;

- (AppDelegate *)appDelegate;

- (WikiViewController *)wikiViewController;

- (WikiArticleDetailViewController *)detailViewControllerWith:(WikiArticle *)article;

- (ArticleViewController *)articleViewControllerWithArticleRequest:(NSString *)articleRequest;

- (ArticleDetailViewController *)articleDetailwithArticle:(Article *)article;

@end

```

### Core

``` objective-c

@interface NWCoreComponents : TyphoonAssembly

- (id<RxHttpClientProtocol>)rxHttpClient;

- (RBTableViewBinding *)tableViewBinding:(UITableView *)tableView
                            sourceSignal:(RACSignal *)source
                        selectionCommand:(RACCommand *)selection
                            templateCell:(UINib *)templateCellNib;



@end

```
## Frameworks


| Pod               | Version         
| -------------     |:-------------:| 
| ReactiveCocoa     | 2.1.8         |
| Typhoon           | 3.0           |
| RxBinding         | 1.0.0         |
| RxNetworking      | 1.0.0        |


