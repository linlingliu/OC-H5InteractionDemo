//
//  OneViewController.m
//  WebView
//
//  Created by LX on 2017/4/19.
//  Copyright © 2017年 LX. All rights reserved.
//
//对JS不熟悉

#import "OneViewController.h"
#import <WebViewJavascriptBridge.h>
@interface OneViewController ()<UIWebViewDelegate>
{
    UIWebView  * _webView;
    WebViewJavascriptBridge   * _bridge;
}
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
    
    UIBarButtonItem *_item=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self  action:@selector(goback:)];
    self.navigationItem.rightBarButtonItem=_item;
    _webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _bridge=[WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"HelloWord.html" withExtension:nil];
    htmlURL=[NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [_webView loadRequest:request];
    [_bridge callHandler:@"myron" data:@{@"name":@"myron",@"age":@"45"} responseCallback:^(id responseData) {
        NSLog(@"fromJS%@",responseData);
    }];
    
    [_bridge registerHandler:@"update" handler:^(id data, WVJBResponseCallback responseCallback) {
       NSLog(@"fromJS%@",data);
        responseCallback(@"linda");
    }];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"Start");
}

- (void)goback:(id)sender{
    [_webView goBack];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finish");
    [_webView stringByEvaluatingJavaScriptFromString:@"function show2() {WebViewJavascriptBridge.callHandler('update',{'name':'mryon'},function responseCallback(responseData){alert(responseData);})}"];
    [_webView stringByEvaluatingJavaScriptFromString:@"show2()"];
}

@end
