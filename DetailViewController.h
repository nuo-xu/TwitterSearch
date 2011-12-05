//
//  DetailViewController.h
//  TwitterSearchUpdate
//
//  Created by Nuo Xu on 11-11-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {

}

@property (retain) NSString *userName;
@property (retain) NSString *postTime;
@property (retain) NSString *tweet;
@property (retain) UIImage *pic;
- (void)name:(NSString *)uName andPostTime:(NSString *)ptime andTweet:(NSString *)tweetContect andProfilePic:(UIImage *)ppic;

@end
