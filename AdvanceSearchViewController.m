//
//  AdvanceSearchViewController.m
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdvanceSearchViewController.h"

@implementation AdvanceSearchViewController
@synthesize containing, notContaining, mentioning, from, to, since, untill, containingField, notContainingField, mentioningField, fromField, toField, untillField, sinceField;;

- (void)dealloc {
    [containing release];
    [notContaining release];
    [mentioning release];
    [from release];
    [to release];
    [since release];
    [untill release];
    [containingField release];
    [notContainingField release];
    [mentioningField release];
    [fromField release];
    [toField release];
    [sinceField release];
    [untillField release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.containing = nil;
        self.notContaining = nil;
        self.mentioning = nil;
        self.from = nil;
        self.to = nil;
        self.since = nil;
        self.untill = nil;
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
//    notContainingField.delegate = self;
//    mentioningField.delegate = self;
//    fromField.delegate = self;
//    toField.delegate = self;
//    sinceField.delegate = self;
//    untillField.delegate = self;
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
    return 7;
}
- (void)createTextField:(UITextField *)textField {
    textField.adjustsFontSizeToFitWidth = YES;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.textAlignment = UITextAlignmentLeft;
    textField.clearButtonMode = UITextFieldViewModeNever;
    [textField setEnabled:YES];
//    [textField addTarget:self action:@selector(textFieldFinished:textField:) forControlEvents:UIControlEventEditingDidEndOnExit];
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
//            if ([indexPath row] == 6) {
//                searchTextField.returnKeyType = UIReturnKeySearch;
//            } else {
//                searchTextField.returnKeyType = UIReturnKeyDefault;
//            }
            switch ([indexPath row]) {
                case 0:
                    self.containingField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.containingField];
                    cell.textLabel.text = @"Containing:";
                    self.containingField.placeholder = @"Bieber:";
                    self.containingField.tag = 0;
                    [cell addSubview:containingField];
                    break;
                case 1:
                    self.notContainingField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.notContainingField];
                    cell.textLabel.text = @"Not\nContaining:";
                    self.notContainingField.placeholder = @"Justin:";
                    self.notContainingField.tag = 1;
                    [cell addSubview:notContainingField];
                    break;
                case 2:
                    self.mentioningField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.mentioningField];
                    cell.textLabel.text = @"Mentioning:";
                    self.mentioningField.placeholder = @"Christmas:";
                    self.mentioningField.tag = 2;
                    [cell addSubview:mentioningField];
                    break;
                case 3:
                    self.fromField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.fromField];
                    cell.textLabel.text = @"From:";
                    self.fromField.placeholder = @"Usher:";
                    self.fromField.tag = 3;
                    [cell addSubview:fromField];
                    break;
                case 4:
                    self.toField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.toField];
                    cell.textLabel.text = @"To:";
                    self.toField.placeholder = @"Justin:";
                    self.toField.tag = 4;
                    [cell addSubview:toField];
                    break;
                case 5:
                    self.sinceField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.sinceField];
                    cell.textLabel.text = @"Since:";
                    self.sinceField.placeholder = @"yyyy-mm-dd:";
                    self.sinceField.tag = 5;
                    [cell addSubview:sinceField];
                    break;
                case 6:
                    self.untillField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
                    [self createTextField: self.untillField];
                    cell.textLabel.text = @"Untill:";
                    self.untillField.placeholder = @"yyyy-mm-dd:";   
                    self.untillField.tag = 6;
                    [cell addSubview:untillField];
                default:
                    break;
            }

        }
    }
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    switch (textField.tag) {
        case 0:
            self.containing = [textField text];
            break;
        case 1:
            self.notContaining = [textField text];
            break;
        case 2:
            self.mentioning = [textField text];
            break;
        case 3:
            self.from = [textField text];
            break;
        case 4:
            self.to = [textField text];
            break;
        case 5:
            self.since = [textField text];
            break;
        case 6:
            self.untill = [textField text];
            break;
        default:
            break;
    }

    return YES;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row & 1) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
