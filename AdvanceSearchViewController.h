//
//  AdvanceSearchViewController.h
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvanceSearchViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>{
    UITextField *containingField, *notContainingField, *mentioningField, *fromField, *untillField, *sinceField;
}

@property (nonatomic, retain) IBOutlet UITextField *containingField, *notContainingField, *mentioningField, *fromField, *untillField, *sinceField;
@property (nonatomic, retain) NSString *containing;
@property (nonatomic, retain) NSString *notContaining;
@property (nonatomic, retain) NSString *mentioning;
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *untill;
@property (nonatomic, retain) NSString *since;

- (void)goToSearchView;

@end
