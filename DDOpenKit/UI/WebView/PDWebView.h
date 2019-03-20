//
//  PDWebView.h
//  PandaKing
//
//  Created by GiganticWhale on 16/7/26.
//  Copyright © 2016年 PandaOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class PDWebView;
@protocol PDWebViewDelegate <NSObject>
@optional
- (void)webView:(PDWebView *)webview didFinishLoadingURL:(NSURL *)URL;
- (void)webView:(PDWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)webView:(PDWebView *)webview shouldStartLoadWithURL:(NSURL *)URL;
- (void)webViewDidStartLoad:(PDWebView *)webview;
@end

@interface PDWebView : UIView

//zlcdelegate
@property (nonatomic, weak) id <PDWebViewDelegate> delegate;

// The main and only UIProgressView
@property (nonatomic, strong) UIProgressView *progressView;
// The web views
// Depending on the version of iOS, one of these will be set
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIWebView *uiWebView;

///Users/GiganticWhale/Desktop/PandaKing//AlipaySDK.bundle

#pragma mark - Initializers view
- (instancetype)initWithFrame:(CGRect)frame;


#pragma mark - Static Initializers
@property (nonatomic, strong) UIBarButtonItem *actionButton;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, assign) BOOL actionButtonHidden;
@property (nonatomic, assign) BOOL showsURLInNavigationBar;
@property (nonatomic, assign) BOOL showsPageTitleInNavigationBar;

@property (nonatomic, strong) NSArray *customActivityItems;



@property (nonatomic,assign)BOOL isCanGoback;
-(void)goBack;
- (void)loadURLString:(NSString *)URLString;
- (void)loadHTMLString:(NSString *)HTMLString;

@end
