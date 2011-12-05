//
//  DetailViewController.m
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-11-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"

@implementation DetailViewController

@synthesize userName, postTime, tweet, pic;


- (void)dealloc 
{
    self.userName = nil;
    self.postTime = nil;
    self.tweet = nil;
    self.pic = nil;
    [super dealloc];
}

- (id) init
{   self = [super init];
    if (self) {
        UIBarButtonItem *searchPageButton = [[UIBarButtonItem alloc] initWithTitle:@"New Search" style:UIBarButtonItemStylePlain target:self action:@selector(goToSearchPage:)];
        self.navigationItem.rightBarButtonItem = searchPageButton;
        [searchPageButton release];

    }
    return self;
}

- (void)goToSearchPage:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{       
    UIImageView *profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 48, 48)];
    profilePic.image = self.pic;
    [self.view addSubview:profilePic];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 200, 20)];
    name.text = self.userName;
    [self.view addSubview:name];
    
    UILabel *pTime = [[UILabel alloc] initWithFrame:CGRectMake(180, 70, 120, 20)];
    pTime.text = [self.postTime substringWithRange:NSMakeRange(5, 20)];
    [pTime setFont:[UIFont systemFontOfSize:10]];
    [self.view addSubview:pTime];
    
    UITextView *tweetContent = [[UITextView alloc] initWithFrame:CGRectMake(10, 90, 300, 350)];
    tweetContent.text = self.tweet;
    tweetContent.dataDetectorTypes = UIDataDetectorTypeAll;
    [tweetContent setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:tweetContent];
    
    [profilePic release];
    [name release];
    [pTime release];
    [tweetContent release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)name:(NSString *)uName andPostTime:(NSString *)ptime andTweet:(NSString *)tweetContect andProfilePic:(UIImage *)ppic
{
    self.userName = uName;
    self.postTime = ptime;
    self.tweet =tweetContect;
    self.pic = ppic;
}

@end
