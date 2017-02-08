//
//  WebViewController.m
//  Vesti
//
//  Created by Biljana on 2/8/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;
@end

@implementation WebViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

# pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //u levom cosku spiner
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinnerView stopAnimating];
    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO; //na sredini vrti
}
@end
