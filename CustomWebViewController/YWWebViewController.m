//
//  YWWebViewController.m
//  yizhen
//
//  Created by 龙章辉 on 15/12/9.
//  Copyright © 2015年 peter. All rights reserved.
//

#import "YWWebViewController.h"


@interface YWWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (nonatomic,strong)UIWebView *webView;


@end

@implementation YWWebViewController

- (instancetype)initWithURL:(NSURL *)url
{
    if (self = [super init])
    {
        [self setup];
        _url = [self cleanURL:url];
    }
    return self;
}

- (instancetype)initWithURLString:(NSString *)urlString
{
    [self setup];
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (NSURL *)cleanURL:(NSURL *)url
{
    //If no URL scheme was supplied, defer back to HTTP.
    if (url.scheme.length == 0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [url absoluteString]]];
    }
    return url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.url && self.webView.request == nil)
    {
        [self.urlRequest setURL:self.url];
        [self.webView loadRequest:self.urlRequest];
    }
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)setup
{
    _showLoadingBar   = YES;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.urlRequest = [[NSMutableURLRequest alloc] init];
}


- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIColor whiteColor];
    view.opaque = YES;
    view.clipsToBounds = YES;
    self.view = view;

    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scalesPageToFit = YES;
    self.webView.contentMode = UIViewContentModeRedraw;
    self.webView.opaque = NO;
    [self.view addSubview:self.webView];
    
    if (_showLoadingBar)
    {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _webView.delegate = _progressProxy;
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        
        CGFloat progressBarHeight = 2.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        
    }

}
-  (void)reloadRequest
{
    if (self.webView.request)
    {
        [self.webView loadRequest:self.urlRequest];
    }
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"navigationType:%d",navigationType);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidStartLoad)]) {
        [self.delegate webViewDidStartLoad];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad)]) {
        [self.delegate webViewDidFinishLoad];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSString* errorString = [NSString stringWithFormat:
                             @";<html><center><font size=+5 color='red'>An error occurred:<br>%@<;/font></center></html>",
                             error.localizedDescription];
    NSLog(@"error:%@",errorString);
    if (self.delegate && [self.delegate respondsToSelector:@selector(webviewDidFailLoadWithError:)]) {
        [self.delegate webviewDidFailLoadWithError:errorString];
    }
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


- (void)dealloc
{
    self.webView.delegate = nil;
    [self.webView stopLoading];
    _progressProxy.webViewProxyDelegate = nil;
    _progressProxy.progressDelegate = nil;
    self.delegate = nil;
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
