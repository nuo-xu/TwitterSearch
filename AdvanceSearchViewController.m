//
//  AdvanceSearchViewController.m
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdvanceSearchViewController.h"
#import "SearchViewController.h"

@implementation AdvanceSearchViewController

@synthesize containingField, notContainingField, mentioningField, fromField, untillField, sinceField, containing, notContaining, mentioning, from, untill, since;

- (void)dealloc {
    [containingField release];
    [notContainingField release];
    [mentioningField release];
    [fromField release];
    [sinceField release];
    [untillField release];
    [containing release];
    [notContaining release];
    [mentioning release];
    [from release];
    [untill release];
    [since release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.containing = @"";
        self.notContaining = @"";
        self.mentioning = @"";
        self.from = @"";
        self.since = @"";
        self.untill = @"";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    containingField.delegate = self;
    notContainingField.delegate = self;
    mentioningField.delegate = self;
    fromField.delegate = self;
    sinceField.delegate = self;
    untillField.delegate = self;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToSearchPage:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(untillFinished:)];
    self.navigationItem.rightBarButtonItem = searchButton;
    [searchButton release];
}

- (void)goBackToSearchPage:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (void)createTextField:(UITextField *)textField {
    textField.adjustsFontSizeToFitWidth = YES;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.textAlignment = UITextAlignmentLeft;
    textField.clearButtonMode = UITextFieldViewModeNever;
    textField.returnKeyType = UIReturnKeyNext;
    [textField setEnabled:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([indexPath section] == 0) {
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            switch ([indexPath row]) {
                case 0:
                    self.containingField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.containingField];
                    cell.textLabel.text = @"Containing:";
                    self.containingField.placeholder = @"Bieber:";
                    [self.containingField addTarget:self action:@selector(containingFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [cell addSubview:containingField];  
                    break;
                case 1:
                    self.notContainingField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.notContainingField];
                    cell.textLabel.text = @"Not\nContaining:";
                    self.notContainingField.placeholder = @"Justin:";
                    [self.notContainingField addTarget:self action:@selector(notContainingFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [cell addSubview:notContainingField];
                    break;
                case 2:
                    self.mentioningField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.mentioningField];
                    cell.textLabel.text = @"Mentioning:";
                    self.mentioningField.placeholder = @"Christmas:";
                    [self.mentioningField addTarget:self action:@selector(mentioningFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [cell addSubview:mentioningField];
                    break;
                case 3:
                    self.fromField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.fromField];
                    cell.textLabel.text = @"From:";
                    self.fromField.placeholder = @"Usher:";
                    [self.fromField addTarget:self action:@selector(fromFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [cell addSubview:fromField];
                    break;
                case 4:
                    self.sinceField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.sinceField];
                    cell.textLabel.text = @"Since:";
                    self.sinceField.placeholder = @"yyyy-mm-dd:";
                    [self.sinceField addTarget:self action:@selector(sinceFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [cell addSubview:sinceField];
                    break;
                case 5:
                    self.untillField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.untillField];
                    cell.textLabel.text = @"Untill:";
                    self.untillField.placeholder = @"yyyy-mm-dd:";   
                    [self.untillField addTarget:self action:@selector(untillFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    self.untillField.returnKeyType = UIReturnKeyNext;
                    [cell addSubview:untillField];
                default:
                    break;
            }

        }
    }
    return cell;
}

- (void)containingFinished: (id)sender {
    [self.notContainingField becomeFirstResponder];
    self.containing = [self.containingField text];
}

- (void)notContainingFinished: (id)sender {
    [self.mentioningField becomeFirstResponder];
    self.notContaining = [self.notContainingField text];
}

- (void)mentioningFinished: (id)sender {
    [self.fromField becomeFirstResponder];
    self.mentioning = [self.mentioningField text];
}

- (void)fromFinished: (id)sender {
    [self.sinceField becomeFirstResponder];

    self.from = [self.fromField text];
    
}

- (void)sinceFinished: (id)sender {
    [self.untillField becomeFirstResponder];
    self.since = [self.sinceField text];
}

- (void)untillFinished: (id)sender {
    self.untill = [self.untillField text];
    [self goToSearchView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row & 1) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (void)goToSearchView {
    if ([self.containing isEqualToString:@""]) {
        UIAlertView *missingRequest = [[UIAlertView alloc] initWithTitle:@"Missing Request" message:@"Please input search pattern!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [missingRequest show];
        [self.containingField becomeFirstResponder];
        [missingRequest release];        
    } else {
        NSLog(@"containing:%@**********", self.containing);
        SearchViewController *searchViewTable = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
        [searchViewTable updateContainingString:self.containing andNotContainingString:self.notContaining andMentioningString:self.mentioning andFromString:self.from andSinceString:self.since andUntillString:self.untill];
        [self.navigationController pushViewController:searchViewTable animated:YES];
        [searchViewTable release];
    }
}

@end
