//
//  ViewController.m
//  Browser
//
//  Created by Biljana on 3/10/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import "ViewController.h"
#import "Bookmark.h"

static NSString *const HOMEPAGE = @"www.google.com"; // in Constants.h

@interface ViewController() <UITextFieldDelegate , UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) NSMutableArray *bookmarksArray;
@end

@implementation ViewController

#pragma mark - Properties

- (NSMutableArray *)bookmarksArray { //lazy loading
    if (!_bookmarksArray) {
        _bookmarksArray = [[NSMutableArray alloc]init];
        
        // Adding predefined bookmarks.
        Bookmark *apple = [[Bookmark alloc] initWithTitle:@"Apple" andURL:@"wwww.apple.com"];
        [_bookmarksArray addObject:apple];
        
        [_bookmarksArray addObject:[[Bookmark alloc] initWithTitle:@"Google" andURL:@"wwww.google.com"]];

    }
    return _bookmarksArray;
}

#pragma mark - Actions
- (IBAction)backBarButtonTapped:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)forwardBarButtonTapped:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (IBAction)shareBarButtonTapped:(UIBarButtonItem *)sender {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Check out this cool link!\n", self.urlTextField.text, [UIImage imageNamed:@"icon"]] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)bookmarksBarButtonTapped:(UIBarButtonItem *)sender {
    [self toggleTableView:YES];
}

- (IBAction)addBarButtonTapped:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Bookmark" message:@"Please add title:" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:nil];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alertController.textFields[0];
        Bookmark *bookmark = [[Bookmark alloc] initWithTitle:textField.text andURL:self.urlTextField.text];
    
        [self.bookmarksArray addObject:bookmark]; //zato sto cemo praviti table view
    [   self.tableView reloadData];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [self toggleTableView:NO];
}

#pragma mark - Private API

/**
 Loads homepage into our web view. If homepage needs to be changed, please update HOMEPAGE constant.
 */
- (void)loadHomepage {
    [self openURL:HOMEPAGE];
}


/**
 Loads url into our web view

 @param urlString The url to open
 */
- (void)openURL:(NSString *)urlString {
    
    NSString *httpString = [NSString stringWithFormat:@"http://%@", urlString];
    NSURL *url = [NSURL URLWithString:httpString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

/**
 Fades in/fades out table view.

 @param toggle Whether we want to fade in or fade out tableView.
 */
- (void)toggleTableView:(BOOL)toggle {
    [UIView animateWithDuration:0.3f animations:^{
        self.tableView.alpha = toggle ? 1.0f : 0.0f; //ako predam toogle YES tableview bice alpha 1, ako predam NO bice 0.
        self.closeButton.alpha = toggle ? 1.0f : 0.0f;
    }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadHomepage];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Hide keyboard
    [textField resignFirstResponder];
    
    [self openURL:textField.text];
    
    return YES;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma  mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookmarksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Bookmark *bookmark = self.bookmarksArray[indexPath.row];
    cell.textLabel.text = bookmark.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Bookmark *bookmark = self.bookmarksArray[indexPath.row];
    [self openURL:bookmark.url];
    
    // sakrij table view kad otvoris URL
    [self toggleTableView:NO];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.bookmarksArray removeObjectAtIndex:indexPath.row]; //moramo u nizu da obrisemo taj bookmark
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft]; //brisemo u tabeli
    }
}

@end
