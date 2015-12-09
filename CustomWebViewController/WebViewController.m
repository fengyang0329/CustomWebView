//
//  WebViewController.m
//  CustomWebViewController
//
//  Created by 龙章辉 on 15/12/9.
//  Copyright © 2015年 Peter. All rights reserved.
//

#import "WebViewController.h"
#import "YWWebViewController.h"


@interface WebViewController ()<UIWebViewDelegate,YWWebViewDelegate>

@property(nonatomic,strong)YWWebViewController *webCtr;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"web测试";
    _webCtr = [[YWWebViewController alloc] initWithURL:[NSURL URLWithString:@"www.baidu.com"]];
    _webCtr.delegate = self;
    
    [self addChildViewController:_webCtr];
    _webCtr.view.frame = self.view.bounds;
    [self.view addSubview:_webCtr.view];
    [_webCtr didMoveToParentViewController:self];
    [_webCtr.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark YWWebViewDelegate
- (void)webviewDidFailLoadWithError:(NSString *)errorString
{
}
- (void)webViewDidStartLoad
{
}
- (void)webViewDidFinishLoad
{
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
