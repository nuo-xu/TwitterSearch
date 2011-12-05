//
//  RootViewController.h
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UITextFieldDelegate> {
    UITextField *searchPattern;
}
@property (nonatomic, retain) UITextField *searchPattern;
@end
