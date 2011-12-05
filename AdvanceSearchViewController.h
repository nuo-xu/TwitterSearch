//
//  AdvanceSearchViewController.h
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvanceSearchViewController : UITableViewController <UITextFieldDelegate>{
    UITextField *containingField, *notContainingField, *mentioningField, *fromField, *toField, *untillField, *sinceField;
}


@property (nonatomic, retain) NSString *containing;
@property (nonatomic, retain) NSString *notContaining;
@property (nonatomic, retain) NSString *mentioning;
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *to;
@property (nonatomic, retain) NSString *untill;
@property (nonatomic, retain) NSString *since;
@property (nonatomic, retain) UITextField *containingField, *notContainingField, *mentioningField, *fromField, *toField, *untillField, *sinceField;

@end
