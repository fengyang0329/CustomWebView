//
//  YWWebViewController.h
//  yizhen
//
//  Created by 龙章辉 on 15/12/9.
//  Copyright © 2015年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol  YWWebViewDelegate <NSObject>

@optional
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error;

@end

@interface YWWebViewController : UIViewController

@property (nonatomic,strong)NJKWebViewProgressView *progressView;
@property (nonatomic,strong)NJKWebViewProgress *progressProxy;
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,strong)NSMutableURLRequest *urlRequest;
@property(nonatomic,weak)id <YWWebViewDelegate>delegate;

/**
 *  是否显示加载进度条
 */
@property(nonatomic,assign)BOOL showLoadingBar;

- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURLString:(NSString *)urlString;

-  (void)reloadRequest;
@end

NS_ASSUME_NONNULL_END