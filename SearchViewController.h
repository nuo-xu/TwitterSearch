//
//  SearchViewController.h
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-11-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController{
    NSString *containing, *notContaining, *mentioning, *from, *since, *untill;
    UIView *refreshHeaderView;
    UIView *loadFooterView;
    UILabel *refreshLabel;
//    UILabel *loadMoreLabel;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    BOOL isFirstRefresh;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    NSString *lastTimeUpdate;
//    NSString *textLoadMore;
//    NSInteger *numberOfCurrentRows;
}

@property (nonatomic, retain) NSString *containing, *notContaining, *mentioning, *from, *since, *untill;
@property (nonatomic, retain) NSMutableData *buffer;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
//@property (nonatomic, retain) UIView *loadFooterView;
//@property (nonatomic, retain) UILabel *loadMoreLabel;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (nonatomic, copy) NSString *lastTimeUpdate;
//@property (nonatomic, copy) NSString *textLoadMore;
//@property (nonatomic) NSInteger *numberOfCurrentRows;


- (void)setupStrings;
- (void)addPullToRefreshHeader;
//- (void)addLoadFooter;
- (void)startLoadingForRefresh;
//- (void)startLoadingForMore;
- (void)stopLoading;
- (void)refresh;
//- (void)loadTenMore;
- (void)updateContainingString: (NSString *)containingString andNotContainingString: (NSString *)notContainingString andMentioningString: (NSString *)mentioningString andFromString: (NSString *)fromString andSinceString: (NSString *)sinceString andUntillString: (NSString *)untillString;
@end
