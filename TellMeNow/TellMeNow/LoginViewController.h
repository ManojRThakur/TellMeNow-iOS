//
//  tellmenowViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface loginViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@end
