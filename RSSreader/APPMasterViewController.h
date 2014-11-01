//
//  APPMasterViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface APPMasterViewController : UITableViewController <NSXMLParserDelegate, ADBannerViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *switchNews;
- (IBAction)ChangeNews:(id)sender;
@end
