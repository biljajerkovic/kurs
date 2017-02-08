//
//  WebViewController.h
//  Vesti
//
//  Created by Biljana on 2/8/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import <UIKit/UIKit.h>
//webViewController is used to present webview. You only need to sent url and that's it
@interface WebViewController : UIViewController

//Set this url in order to prsent web View with loaded website (from url).
@property (strong, nonatomic) NSString *url;
@end
