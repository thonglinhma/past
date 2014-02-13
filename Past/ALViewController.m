//
//  ALViewController.m
//  Past
//
//  Created by Mike Tran on 22/1/14.
//  Copyright (c) 2014 Abcdefghijk Lab. All rights reserved.
//

#import <Parse/Parse.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ALViewController.h"

@interface ALViewController ()
- (IBAction)fbSignInAction:(id)sender;

@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fbSignInAction:(id)sender
{
   RACSignal *logInSignal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [PFFacebookUtils logInWithPermissions:@[ @"email"] block:^(PFUser *user, NSError *error) {
            if (!user) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.xxxxx");
            } else if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
            } else {
                NSLog(@"User logged in through Facebook!");
            }
            if (!error) {
                [subscriber sendNext:user];
            } else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
       
    }] doError:^(NSError *error) {
        
    }];
    
    [PFFacebookUtils logInWithPermissions:@[ @"email"] block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}
@end
