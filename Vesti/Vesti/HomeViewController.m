//
//  HomeViewController.m
//  Vesti
//
//  Created by Biljana on 2/3/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import "HomeViewController.h"
#import "Article.h"
#import "ArticleTableViewCell.h"
#import "WebViewController.h"
#import "Reachability.h"

//#define URL @"http://www.brzevesti.net/api/news"
static NSString *const URL = @"http://www.brzevesti.net/api/news";
static NSString *const STORYBOARD = @"Main";
//static znaci da se nece nikad menjati

@interface HomeViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray; //articlesArray
@end

@implementation HomeViewController

#pragma mark - Private API

- (void)loadArticles {
    //Grand Central Dispatch (GCD)
    dispatch_queue_t downloadQueue = dispatch_queue_create("articlesDownloader", nil);
    dispatch_async(downloadQueue, ^{
       //This code will be executed on BACKGROUND thread
        NSURL *url = [NSURL URLWithString:URL];
        NSData *data = [NSData dataWithContentsOfURL:url]; //skupljamo podatke sa web; data vreca bajtova
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", url);
        NSLog(@"%@", dictionary);
        
        self.itemsArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *articleDictionary in dictionary[@"news"]) {
            Article *article = [[Article alloc] initWithDictionary:articleDictionary];
            [self.itemsArray addObject:article];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //This code will be executed on MAIN thread
            [self.tableView reloadData];
        });
    });
}

- (BOOL)isConnected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi || status == ReachableViaWWAN) {
        return YES;
    }
    return NO;
}

- (void)showConnectionError {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Network Error" message:@"Please provide Internet connection" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (UIViewController *)viewControllerForIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

-(void)showArticle:(Article *)article {
    WebViewController *toViewController = (WebViewController *)[self viewControllerForIdentifier:NSStringFromClass([WebViewController class])];
    
    toViewController.url = article.url;
    [self.navigationController pushViewController:toViewController animated:YES];
}
                               
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self isConnected]) {
        [self loadArticles];
    } else {
        [self showConnectionError];
    }
}

#pragma  mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.article = self.itemsArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Show WebViewController
    if ([self isConnected]) {
        Article *article = self.itemsArray[indexPath.row];
        [self showArticle:article];
    } else {
        [self showConnectionError];
    }
}

@end
