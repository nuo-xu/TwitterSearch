//
//  RootViewController.m
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "SearchViewController.h"
#import "AdvanceSearchViewController.h"

@implementation RootViewController
@synthesize searchPattern;
- (id)init
{   self = [super init];
    if (self) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItemStylePlain;
    }
    return  self;
}

- (void)loadView
{
    //allocate the view
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    //set the view's background color
    self.view.backgroundColor = [UIColor whiteColor];
    
    //set the view's title
    self.title = @"TwitterSearch";
}

- (void)viewDidLoad
{
    [super viewDidUnload];
    UILabel *rootLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    rootLabel.textAlignment = UITextAlignmentCenter;
    rootLabel.text = @"Input search pattern";
    [self.view addSubview:rootLabel];
    [rootLabel release];
    
    self.searchPattern = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 25)];
    self.searchPattern.delegate = self;
    self.searchPattern.borderStyle = UITextBorderStyleRoundedRect;
    self.searchPattern.placeholder = @"<Enter Text>";
    self.searchPattern.textAlignment = UITextAlignmentCenter;
    [self.searchPattern setReturnKeyType:UIReturnKeySearch];
    [self.view addSubview:self.searchPattern];
    
    UIButton *advancSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    advancSearchButton.frame = CGRectMake(85, 120, 150, 30);
    [advancSearchButton setTitle:@"Advance Search" forState:UIControlStateNormal];
    [advancSearchButton addTarget:self action:@selector(goToAdvanceSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:advancSearchButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	SearchViewController *searchTable = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    searchTable.containing = [textField text];
    [textField resignFirstResponder];
    if ([searchTable.containing isEqualToString:@""]) {
        UIAlertView *missingRequest = [[UIAlertView alloc] initWithTitle:@"Missing Request" message:@"Please input search pattern!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [missingRequest show];
        //        [self.containingField becomeFirstResponder];
        [missingRequest release];  
        [textField becomeFirstResponder];
        return NO;
    } else {
        [[self navigationController] pushViewController:searchTable animated:YES];
        textField.text = @"";
        [searchTable release];
        return YES;
    }
}

- (void)goToAdvanceSearch:(id)sender{
    AdvanceSearchViewController *advanceSearchView = [[AdvanceSearchViewController alloc] initWithStyle:UITableViewStylePlain];
    if ([self.searchPattern text]) {
        advanceSearchView.containingField.text = [self.searchPattern text];
//        advanceSearchView.containingField
    }
    [self.navigationController pushViewController:advanceSearchView animated:YES];
    [advanceSearchView release];
}

- (void)dealloc
{
    [super dealloc];
    [self.searchPattern release];
}

@end
