//
//  JRHttpClient.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "JRHttpClient.h"

@interface JRHttpClient ()

@property (nonatomic) NSURLSession *session;

@end

@implementation JRHttpClient

#pragma mark - private

+ (instancetype)sharedClient {
    static JRHttpClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] initPrivate];
    });
    
    return sharedClient;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[HttpClient sharedClient]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config
                                                     delegate:self
                                                delegateQueue:nil];
    }
    return self;
}

#pragma mark - JRHttpClientProtocol methods

- (void)performRequestWith:(NSString *)sUrl query: (NSDictionary *)q {
    NSURL *url = [self url:sUrl withQuery:q];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
        
        if (self.delegate) {
            [self.delegate downloadCompletedWith:jsonObject];
        }
    }];
    [dataTask resume];
}

#pragma mark - internals

- (NSURL *)url:(NSString *)sUrl withQuery:(NSDictionary *)q {
    NSMutableString *urlWithQuery = [NSMutableString stringWithFormat:@"%@?", sUrl];
    NSMutableArray *parts = [NSMutableArray array];
    
    for (NSString *params in q) {
        NSString *part = [NSString stringWithFormat: @"%@=%@", params, [q objectForKey:params]];
        [parts addObject: part];
    }
    
    [urlWithQuery appendString:[parts componentsJoinedByString:@"&"]];
    
    return [NSURL URLWithString:urlWithQuery];
}

@end
