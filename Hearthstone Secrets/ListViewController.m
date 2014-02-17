//
//  ListViewController.m
//  Hearthstone Secrets
//
//  Created by Lacock, Ty on 1/24/14.
//  Copyright (c) 2014 TWL. All rights reserved.
//

#import "ListViewController.h"
#import <iAd/iAd.h>

#define kMageSegment 0
#define kHunterSegment 1
#define kPaladinSegment 2

@interface ListViewController () <ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet ADBannerView *banner;

@property NSArray *entries;

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.entries = @[];
    [self loadFromSegment:@"mage"];
    self.canDisplayBannerAds = YES;
    self.banner.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadFromSegment:(NSString *)segment;
{
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"hearth" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:plistCatPath];
    
    NSError *jsonError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    
    self.entries = [json objectForKey:segment];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}


- (IBAction)didChangeSegment:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    if (control.selectedSegmentIndex == kMageSegment) {
        NSString *mage = @"mage";
        [self loadFromSegment:mage];
    } else if (control.selectedSegmentIndex == kHunterSegment) {
        NSString *hunter = @"hunter";
        [self loadFromSegment:hunter];
    } else {
        NSString *paladin = @"paladin";
        [self loadFromSegment:paladin];
    }
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -  Table view data source
///////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *entry = [self.entries objectAtIndex:indexPath.row];
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1000];
    UITextView *text = (UITextView *)[cell viewWithTag:1001];
    UIImageView *image = (UIImageView *)[cell viewWithTag:1002];
    
    image.image = [UIImage imageNamed:[entry objectForKey:@"image"]];
    label1.text = [entry objectForKey:@"name"];
    text.text = [entry objectForKey:@"descr"];

    
    return cell;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -  iAd stuff
///////////////////////////////////////////////////////////////////////////////
-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    
    [UIView commitAnimations];
}

@end
