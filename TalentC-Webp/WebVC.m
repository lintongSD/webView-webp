//
//  WebVC.m
//  TalentC-Webp
//
//  Created by chuliangliang on 2017/4/6.
//  Copyright © 2017年 chuliangliang. All rights reserved.
//

#import "WebVC.h"
#import <WebKit/WebKit.h>
#import "NSURLProtocolWebkitExt.h"
#import "SDWebImageManager.h"


@interface WebVC ()<WKNavigationDelegate>
@property (strong, nonatomic) UIView *webView;
@property (assign, nonatomic) WEBType currentType;
@end

@implementation WebVC


- (void)dealloc{
    NSLog(@"WebVC -- dealloc webview:%p",self.webView);
    if ([self.webView isKindOfClass:[WKWebView class]]) {
        [NSURLProtocol unregisterClass:NSClassFromString(@"CLURLProtocol")];
        [NSURLProtocol wk_unregisterScheme:@"http"];
        [NSURLProtocol wk_unregisterScheme:@"https"];
        
        WKWebView *web = (WKWebView *)self.webView;
        [web.configuration.userContentController removeAllUserScripts];
        web.navigationDelegate = nil;
        self.webView = nil;
    }
    
    //清除缓存
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *appCacheDir = [NSString stringWithFormat:@"%@/Caches",libraryDir];
    NSArray *dirArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:appCacheDir error:nil];
    for (NSString *subPath in dirArray) {
        NSError *error = nil;
        BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:[appCacheDir stringByAppendingPathComponent:subPath] error:&error];
        if (isSuccess) {
            NSLog(@"移除缓存");
        }
    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

- (instancetype)initWithWebType:(WEBType)type
{
    self = [super init];
    if (self) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        config.userContentController = [WKUserContentController new];
        if ([config respondsToSelector:@selector(setWebsiteDataStore:)]) {
            [config setWebsiteDataStore:[WKWebsiteDataStore nonPersistentDataStore]]; //是否隐私模式 不保留缓存
        }
        WKWebView *web = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        web.navigationDelegate = self;
        self.webView = web;
        
        
        [self.view addSubview:self.webView];
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat W = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat H = CGRectGetHeight([UIScreen mainScreen].bounds);
    self.webView.frame = CGRectMake(0, 64, W, H-64);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *url = @"http://onzbjws3p.bkt.clouddn.com/testForwebpSrc/webpForhtml.html";
    
    self.title = @"WKWebView load webp";
    //注册自定义 NSURLProtocol
    [NSURLProtocol registerClass:NSClassFromString(@"CLURLProtocol")];
    [NSURLProtocol wk_registerScheme:@"http"];
    [NSURLProtocol wk_registerScheme:@"https"];

        
    //发起请求
    WKWebView *web = (WKWebView *)self.webView;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    NSLog(@"webview:%p",self.webView);
    
}



#pragma mark-
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

@end
