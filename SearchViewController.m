//
//  SearchViewController.m
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-11-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "SBJSON.h"
#import "DetailViewController.h"

@interface NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
@end

@implementation NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
	return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)self,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(encoding));
}
@end

@interface SearchViewController ()
- (void)loadQuery;
- (void)handleError:(NSError *)error;
@end

@implementation SearchViewController

@synthesize containing, notContaining, mentioning, from, since, untill, buffer, connection, results, textPull, textRelease, textLoading, lastTimeUpdate, refreshHeaderView, refreshLabel, refreshSpinner, minusSign, atSign, sinceColon, fromColon, untillColon;

- (void)dealloc
{
    self.containing = nil;
    self.containing = nil;
    self.notContaining = nil;
    self.mentioning = nil;
    self.from = nil;
    self.since = nil;
    self.untill = nil;
    self.buffer = nil;
    self.connection = nil;
    self.results = nil;
    self.textPull = nil;
    self.textRelease = nil;
    self.textLoading = nil;
    self.refreshHeaderView = nil;
    self.refreshLabel = nil;
    self.refreshSpinner = nil;
    self.lastTimeUpdate = nil;
    self.minusSign = nil;
    self.atSign = nil;
    self.sinceColon = nil;
    self.fromColon = nil;
    self.untillColon = nil;
//    self.numberOfCurrentRows = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        isFirstRefresh = YES;
        self.containing = @"";
        self.containing = @"";
        self.notContaining = @"";
        self.mentioning = @"";
        self.from = @"";
        self.since = @"";
        self.untill = @"";
        self.minusSign = @"";
        self.atSign = @"";
        self.fromColon = @"";
        self.sinceColon = @"";
        self.untillColon = @"";
        [self setupStrings];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.containing;
    [self loadQuery];
    [self addPullToRefreshHeader];
//    [self addLoadFooter];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.connection cancel];
    
    self.connection = nil;
    self.buffer = nil;
    self.results = nil;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#define DEFAULT_NUMBER_OF_TWEETS_IN_ONE_PAGE 20;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    self.numberOfCurrentRows = DEFAULT_NUMBER_OF_TWEETS_IN_ONE_PAGE;
    NSUInteger count = [self.results count];
    return count > 0 ? count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ResultCellIdentifier = @"ResultCell";
    static NSString *LoadCellIdentifier = @"LoadingCell";
    
    NSUInteger count = [self.results count];
    if ((count == 0) && (indexPath.row == 0)) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadCellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:LoadCellIdentifier] autorelease];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
        
        if (!self.connection) {
            cell.textLabel.text = @"Not available";
        }
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ResultCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:ResultCellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSDictionary *tweet = [self.results objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", [tweet objectForKey:@"from_user"],
                           [tweet objectForKey:@"text"]];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[tweet objectForKey:@"profile_image_url"]]]];
	
	cell.imageView.image = image;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row & 1) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *onetweet = [self.results objectAtIndex:indexPath.row];
    DetailViewController *detailView = [[DetailViewController alloc] init];
    
    // pass the data
    NSString* userName = [NSString stringWithFormat:@"%@: ", [onetweet objectForKey:@"from_user"]];
    NSString* tweet = [onetweet objectForKey:@"text"];
    NSString* postTime = [onetweet objectForKey:@"created_at"];
    UIImage* pic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[onetweet objectForKey:@"profile_image_url"]]]];
    
    [detailView name:userName andPostTime:postTime andTweet:tweet andProfilePic:pic];
    
    [self.navigationController pushViewController:detailView animated:YES];
    [detailView release];

}

- (void)updateContainingString: (NSString *)containingString andNotContainingString: (NSString *)notContainingString andMentioningString: (NSString *)mentioningString andFromString: (NSString *)fromString andSinceString: (NSString *)sinceString andUntillString: (NSString *)untillString {
    if (![notContainingString isEqualToString:@""]) {
        self.minusSign = @"-";
    }
    if (![mentioningString isEqualToString:@""]) {
        self.atSign = @"@";
    }
    if (![fromString isEqualToString:@""]) {
        self.fromColon = @"from:";
    }
    if (![sinceString isEqualToString:@""]) {
        self.sinceColon = @"since:";
    }
    if (![untillString isEqualToString:@""]) {
        self.untillColon = @"untill:";
    }
    self.containing = containingString;
    self.notContaining = [NSString stringWithFormat:@" -%@ ", notContainingString];
    self.mentioning = [NSString stringWithFormat:@"%@ ", mentioningString];
    self.from = [NSString stringWithFormat:@"%@ ", fromString];
    self.since = [NSString stringWithFormat:@"%@ ", sinceString];
    self.untill = [NSString stringWithFormat:@"%@ ", untillString];
    NSLog(@"containing: %@\notcontaining: %@\nmentioning: %@\nfrom: %@\nsince: %@\nuntill: %@", self.containing, self.notContaining, self.mentioning, self.from, self.since, self.untill);
    self.notContaining = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.notContaining, NULL, (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
    self.mentioning = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.mentioning, NULL, (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
    self.from = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.from, NULL, (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
    self.since = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.since, NULL, (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
    self.untill = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.untill, NULL, (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
}

#define RESULTS_PERPAGE 40

- (void)loadQuery {    
    NSString *path = [NSString stringWithFormat:@"http://search.twitter.com/search.json?rpp=%d&q=%@", RESULTS_PERPAGE, self.containing];
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@", path, self.notContaining, self.atSign, self.mentioning, self.fromColon, self.from, self.sinceColon, self.since, self.untillColon, self.untill];
    NSLog(@"url: %@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    self.buffer = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.connection = nil;
    
    NSString *jsonString = [[NSString alloc] initWithData:self.buffer encoding:NSUTF8StringEncoding];
    NSDictionary *jsonResults = [jsonString JSONValue];
    self.results = [jsonResults objectForKey:@"results"];
    
    [jsonString release];
    self.buffer = nil;
    [self.tableView reloadData];
    [self.tableView flashScrollIndicators];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.connection = nil;
    self.buffer = nil;
    
    [self handleError:error];
    [self.tableView reloadData];
}

- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error"                              
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)setupStrings{
    textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
    textLoading = [[NSString alloc] initWithString:@"Loading..."];
//    textLoadMore = [[NSString alloc] initWithString:@"Release to load more..."];
}

#define REFRESH_HEADER_HEIGHT 52.0f
- (void)addPullToRefreshHeader {
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = UITextAlignmentCenter;
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshSpinner];
    [self.tableView addSubview:refreshHeaderView];
}

//#define LOAD_MORE_FOOTER_HEIGHT 52.0f
//- (void)addLoadFooter {
//    loadFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height + LOAD_MORE_FOOTER_HEIGHT, 320, LOAD_MORE_FOOTER_HEIGHT)];
//    loadFooterView.backgroundColor = [UIColor clearColor];
//    
//    loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, LOAD_MORE_FOOTER_HEIGHT)];
//    loadMoreLabel.backgroundColor = [UIColor clearColor];
//    loadMoreLabel.font = [UIFont boldSystemFontOfSize:12.0];
//    loadMoreLabel.textAlignment = UITextAlignmentCenter;
//    
//    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
//    refreshSpinner.hidesWhenStopped = YES;
    
//    [loadFooterView addSubview:loadMoreLabel];
//    [refreshHeaderView addSubview:refreshSpinner];
//    self.tableView.tableFooterView = loadFooterView;
//    [self.tableView addSubview:refreshHeaderView];
        
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
    if (!isFirstRefresh) {
        NSDateFormatter *formatter;
        NSString        *dateString;
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-dd-MM HH:mm"];
        dateString = [formatter stringFromDate:[NSDate date]];
        dateString = [NSString stringWithFormat:@"Last Update: %@", dateString];
        [formatter release];  
        lastTimeUpdate = [[NSString alloc] initWithString:dateString];
        
    } else {
        lastTimeUpdate = [[NSString alloc] initWithString:@""];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSInteger currentOffset = scrollView.contentOffset.y;
//    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.tableView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            [refreshLabel setNumberOfLines:2];
            refreshLabel.text = [NSString stringWithFormat:@"%@\n%@", self.textRelease, self.lastTimeUpdate];
        } else {
            refreshLabel.text = [NSString stringWithFormat:@"%@\n%@", self.textPull, self.lastTimeUpdate];
        }
        isFirstRefresh = NO;
        [UIView commitAnimations];
    }
//    } else if(isDragging && maximumOffset - currentOffset <= 10.0){
//        loadMoreLabel.text = self.textLoadMore;
//    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
//    NSInteger currentOffset = scrollView.contentOffset.y;
//    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoadingForRefresh];
    }
//    } else if (maximumOffset - currentOffset <= 10.0){
//        [self startLoadingForMore];
//    }
}

- (void)startLoadingForRefresh {
    isLoading = YES;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.tableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    refreshLabel.text = self.textLoading;
    [refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    [self refresh];
}

//- (void)startLoadingForMore {
//    isLoading = YES;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, LOAD_MORE_FOOTER_HEIGHT, 0);
//    loadMoreLabel.text = self.textLoading;
////    [refreshSpinner startAnimating];
//    [UIView commitAnimations];
//    
//    [self loadTenMore];
//}

- (void)stopLoading {
    isLoading = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.tableView.contentInset = UIEdgeInsetsZero;
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    refreshLabel.text = self.textPull;
    [refreshSpinner stopAnimating];
}

- (void)refresh {
    [self loadQuery];
    [self.tableView reloadData];
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];

}

//- (void)loadTenMore {
//    for (NSInteger i = 1; i < 11; ++i) {
//        NSInteger *indexOfNewTweet = i + self.numberOfCurrentRows;
//        NSDictionary *tweet = [self.results objectAtIndex: indexOfNewTweet];
//     
//    }
//    
//}

@end
