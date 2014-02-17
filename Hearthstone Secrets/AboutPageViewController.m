//
//  AboutPageViewController.m
//  Hearthstone Secrets
//
//  Created by Ty Lacock on 2/16/14.
//  Copyright (c) 2014 TWL. All rights reserved.
//

#import "AboutPageViewController.h"
#import <MessageUI/MessageUI.h>

@interface AboutPageViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation AboutPageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:1.000 green:0.836 blue:0.405 alpha:1.000]};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"tywlacock@gmail.com"]];
        [composeViewController setSubject:@"Hearthstone Secrets App"];
        [self presentViewController:composeViewController animated:YES completion:nil];

    } else if (indexPath.row == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.tylacock.com/hearth"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/hearthsecrets"]];
    }
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
