//
//  APPDetailViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface APPDetailViewController : UIViewController<ADBannerViewDelegate>

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *strTitle;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
