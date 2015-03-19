//
//  SidebarTableViewController.h
//  Dupa
//
//  Created by Łukasz Kowalski on 09/02/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIView *search;
@property (nonatomic, assign) BOOL cellOpened;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;


@end
