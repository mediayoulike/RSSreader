//
//  APPMasterViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPMasterViewController.h"

#import "APPDetailViewController.h"

@interface APPMasterViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *pubDate;
    NSMutableString *imageFile;
    NSString *element;
}
@end

@implementation APPMasterViewController

@synthesize switchNews;

bool beBilingual = true;

NSString *strNewsType;
NSString *strNewsTitle;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    feeds = [[NSMutableArray alloc] init];
 //   NSURL *url = [NSURL URLWithString:@"http://www.voachinese.com/api/epiqq"];
    //@"http://www.qidian.com/rss.aspx"];
    //@"http://www.youku.com/playlist/rss/id/5126675"];
    //@"http://www.youku.com/index/rss_cool_v
    //@"http://www.youku.com/index/rss_cool_v"];
    //@"http://www.littleducks.cn/data/rss/21.xml"];
    //@"http://www.youku.com/playlist/rss/id/2507461"];
    //@"http://www.youku.com/playlist/rss/id/5447767"];
    //@"http://music.hujiang.com/rss/"];
    //@"http://www.youku.com/playlist/rss/id/20611292"];
    //@"http://www.voachinese.com/api/z-$trevtuo"];
    //@"http://www.voachinese.com/api/ztyypeiqvm"];
    //@"http://www.voachinese.com/api/epiqq"];
    //@"http://www.voachinese.com/api/"];
    //@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    //@"http://www.aboluowang.com/rss.xml"];
    //@"http://www.secretchina.com/rss/latest/index.html"];
                  
    //@"http://www.chinapost.com.tw/rss/asia.xml"];
    
    
    NSURL *url;
    
    if([strNewsType isEqual:@"All"])
    {
        url = [NSURL URLWithString:@"http://www.voachinese.com/api/epiqq"];
        strNewsTitle = @"综合新闻";
    }
    else if([strNewsType isEqual:@"USA"])
    {
        url = [NSURL URLWithString:@"http://www.voachinese.com/api/zg_yre_rvq"];
        strNewsTitle = @"美国新闻";
    }
    else if([strNewsType isEqual:@"China"])
    {
        url = [NSURL URLWithString:@"http://www.voachinese.com/api/zyyyoeqqvi"];
        strNewsTitle = @"中国新闻";
    }
    else if([strNewsType isEqual:@"Bilingual"])
    {
        url = [NSURL URLWithString:@"http://www.voachinese.com/api/z-$trevtuo"];
        strNewsTitle = @"双语新闻";
    }
    else if([strNewsType isEqual:@"Learning"])
    {
        url = [NSURL URLWithString:@"http://learningenglish.voanews.com/api/"];
        strNewsTitle = @"英语学习";
    }
    else if([strNewsType isEqual:@"English"])
    {
        url = [NSURL URLWithString:@"http://www.voanews.com/api/"];
        strNewsTitle = @"英文新闻";
    }
    else
    {
         url = [NSURL URLWithString:@"http://www.voanews.com/api/"];
         strNewsTitle = @"综合新闻";
    }
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
 //   [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self viewDidLoad];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString* strTemp1 = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    NSString* strTemp2 = [[feeds objectAtIndex:indexPath.row] objectForKey: @"pubDate"];
    
    strTemp1 = [strTemp1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    strTemp1 = [strTemp1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    strTemp2 = [strTemp2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
 /*  cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", strTemp1, strTemp2];*/
    
    cell.textLabel.text = strTemp1;
    
//    NSString* strTemp3 = [[feeds objectAtIndex:indexPath.row] objectForKey: @"enclosure"];
    
//    cell.textLabel.text = strTemp3;
    
    return cell;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([elementName isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        pubDate = [[NSMutableString alloc] init];
        imageFile = [[NSMutableString alloc] init];
    }
    
    // just do this for item elements
    //      <enclosure url="http://gdb.voanews.com/737D3BEC-07A2-497A-8EC6-7E7D24D06FAB_cx0_cy20_cw0_w800_h450.png" length="3123" type="image/jpeg"/>

    if([elementName isEqual:@"enclosure"])// then you just need to grab each of your attributes
    {
        NSString * name = [attributeDict objectForKey:@"url"];
        [imageFile appendString:name];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:pubDate forKey:@"pubDate"];
        [item setObject:imageFile forKey:@"enclosure"];

        [feeds addObject:[item copy]];
        
    }
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
  
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }else if ([element isEqualToString:@"pubDate"]) {
        [pubDate appendString:string];
/*    }else if ([element isEqualToString:@"enclosure"]) {
        [imageFile appendString:string];*/
    }else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *strLink = [feeds[indexPath.row] objectForKey: @"link"];
        strLink = [strLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        strLink = [strLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        [[segue destinationViewController] setUrl:strLink];
        [[segue destinationViewController] setStrTitle:strNewsTitle];
        
    }
}

#pragma mark iAd Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}


- (IBAction)ChangeNews:(id)sender {
    
        if(switchNews.selectedSegmentIndex == 0)
            strNewsType = @"All";
        else if(switchNews.selectedSegmentIndex == 1)
            strNewsType = @"USA";
        else if(switchNews.selectedSegmentIndex == 2)
              strNewsType = @"China";
        else if(switchNews.selectedSegmentIndex == 3)
            strNewsType = @"Bilingual";
        else if(switchNews.selectedSegmentIndex == 4)
            strNewsType = @"Learning";
        else if(switchNews.selectedSegmentIndex == 5)
            strNewsType = @"English";
    
        [self viewDidLoad];
        [self.tableView reloadData];
}
@end
