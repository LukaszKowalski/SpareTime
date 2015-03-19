//
//  SidebarTableViewController.m
//  Dupa
//
//  Created by Łukasz Kowalski on 09/02/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "PartyTableViewCell.h"
#import "firstCellTableViewCell.h"
#import "separatorTableViewCell.h"
#import "normalTableViewCell.h"

#define Category_Box_Height 72
#define Category_Subclass_Height 36
#define Category_Object_Height 152


@interface SidebarTableViewController ()

@property (nonatomic, strong) NSMutableArray *expandedPaths;


@end

@implementation SidebarTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"tableView" owner:self options:nil]objectAtIndex:0];
    [self.view addSubview:self.contentTableView];
    self.search = [[UIView alloc] initWithFrame:CGRectMake(8, 8, 274, 36)];
    self.search.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.search];
    
    UITextField *serchTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 274, 36)];
    
    UIColor *color = [UIColor whiteColor];
    serchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Szukaj" attributes:@{NSForegroundColorAttributeName: color}];
    
    serchTextField.textColor = [UIColor whiteColor];
    [self.search addSubview: serchTextField];
    
    //    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetTableView)
                                                 name:@"resetsideBar"
                                               object:nil];
}



-(void)resetTableView{
    
  

    [self.contentTableView reloadData];
    NSLog(@"reset");
    [self.view layoutIfNeeded];
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= Category_Box_Height) {
        self.search.backgroundColor = [UIColor blueColor];
        
    }
    if (scrollView.contentOffset.y < Category_Box_Height) {
        self.search.backgroundColor = [UIColor clearColor];
        
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        return 88;
//    }
//    return 250;
//    
//}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }
    if (indexPath.row % 2 != 0){
        return 16;
    }
    if ([self.expandedPaths containsObject:indexPath]) {
        return 300;
    }
    return 190;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.expandedPaths == nil) {
        self.expandedPaths = [[NSMutableArray alloc] init];
    }
    
    if([self.expandedPaths containsObject:indexPath]) {
        [self.expandedPaths removeObject:indexPath];
        
    } else {
        [self.expandedPaths addObject:indexPath];
    }
    
    NSLog(@"komorki rozszerzone %@", [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]);
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    NSLog(@"DOTKNALEM %ld", (long)indexPath.row);

}

#pragma mark -
#pragma mark UITableView Datasource



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    static NSString *firstCellIdentifier = @"firstCell";
    static NSString *separatorCellIdentifier = @"separatorCell";
    static NSString *normalCellIdentifier = @"normalCell";

//    
//    
//    if([self.expandedPaths containsObject:indexPath]) {
//        self.cellOpened = YES;
//    }else{
//        self.cellOpened = NO;
//    }
    firstCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier ];
    separatorTableViewCell *separatorCell = [tableView dequeueReusableCellWithIdentifier:separatorCellIdentifier];
    normalTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
    
    if (indexPath.row == 0) {
        [tableView registerNib:[UINib nibWithNibName:@"firstCell" bundle:nil] forCellReuseIdentifier:firstCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
        return cell;
    }
    if (indexPath.row % 2 != 0) {
        [tableView registerNib:[UINib nibWithNibName:@"separator" bundle:nil] forCellReuseIdentifier:separatorCellIdentifier];
        separatorCell = [tableView dequeueReusableCellWithIdentifier:separatorCellIdentifier];
        return separatorCell;
    }
    if (indexPath.row != 0 && indexPath.row % 2 == 0) {
        [tableView registerNib:[UINib nibWithNibName:@"normalCell" bundle:nil] forCellReuseIdentifier:normalCellIdentifier];
        normalCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        return normalCell;
    }

    
    return cell;
}
- (void)changeDay{
    NSLog(@"Dupa kutas cycki");
}

@end
