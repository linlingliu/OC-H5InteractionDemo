//
//  TwoViewController.m
//  WebView
//
//  Created by LX on 2017/4/19.
//  Copyright © 2017年 LX. All rights reserved.
//

#import "TwoViewController.h"
#import <WebKit/WebKit.h>
#import <WKWebViewJavascriptBridge.h>

@interface TwoViewController ()<WKNavigationDelegate,WKUIDelegate>
{
    WKWebView   * _wkWebView;
    WKWebViewJavascriptBridge  * _bridge;
}
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration * _con=[WKWebViewConfiguration new];
    _wkWebView=[[WKWebView alloc]initWithFrame:self.view.bounds configuration:_con];
    _wkWebView.navigationDelegate=self;
    //_wkWebView.UIDelegate=self;
    [self.view addSubview:_wkWebView];
    //NSURL *cssURL = [[NSBundle mainBundle] URLForResource:@"css.css" withExtension:nil];
    //[_wkWebView loadFileURL:cssURL allowingReadAccessToURL:cssURL];
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"HelloWord.html" withExtension:nil];
    
    [_wkWebView loadFileURL:htmlURL allowingReadAccessToURL:htmlURL];
    //[_wkWebView loadRequest:_request];
//    _bridge=[WKWebViewJavascriptBridge bridgeForWebView:_wkWebView];
//    [_bridge registerHandler:@"update" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"%@",data);
//        responseCallback(data);
//    }];
//    [_bridge callHandler:@"myron" data:@{@"name":@"myron",@"age":@"45"} responseCallback:^(id responseData) {
//        NSLog(@"fromJS%@",responseData);
//    }];
}
#pragma mark--UIDeleagte
/*  警告 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    [[[UIAlertView alloc] initWithTitle:@"警告框" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] show];
    completionHandler();
}
///** 确认框 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    [[[UIAlertView alloc] initWithTitle:@"确认框" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] show];
    
    completionHandler(1);
}
/**  输入框 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    [[[UIAlertView alloc] initWithTitle:@"输入框" message:prompt delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] show];
    completionHandler(@"你是谁！");
}


// 创建新的webView
// 可以指定配置对象、导航动作对象、window特性。如果没用实现这个方法，不会加载链接，如果返回的是原webview会崩溃。WKNavigationDelegate中的该方法是用户点击网页上的链接，需打开新页面时，将先调，是否允许跳转到链接
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return nil;
}
// webview关闭时回调
- (void)webViewDidClose:(WKWebView *)webView{
    
}

#pragma mark --UINaviagtionDelegate
//页面开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"start");
}
//页面完成加载时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [_wkWebView evaluateJavaScript:@"function show2(){x=document.getElementById(Demo); }" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",result);
    }];
}

//页面加载错误时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
//// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    /**
     *typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
     WKNavigationActionPolicyCancel, // 取消
     WKNavigationActionPolicyAllow,  // 继续
     }
     */
    decisionHandler(WKNavigationActionPolicyAllow);
}
//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
//身份验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    // 不要证书验证
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}
//在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
}
//导航错误
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}
@end
