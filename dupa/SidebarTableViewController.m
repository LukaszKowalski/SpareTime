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
#import "leftViewModel.h"

#define Category_Box_Height 72
#define Category_Subclass_Height 36
#define Category_Object_Height 152


@interface SidebarTableViewController ()

@property (nonatomic, strong) NSMutableArray *expandedPaths;
@property (nonatomic, strong) NSMutableSet *set_OpenIndex;
@property (nonatomic, strong) NSArray *cinemaNames;
@property (assign, nonatomic) CGPoint lastContentOffset;

@end

@implementation SidebarTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"tableView" owner:self options:nil]objectAtIndex:0];
    self.view.frame = CGRectMake(self.view.frame.origin.x, -250, self.view.frame.size.width, self.view.frame.size.height);
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.contentTableView.contentInset =  UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.view addSubview:self.contentTableView];
    self.search = [[UIView alloc] initWithFrame:CGRectMake(8, 8, 274, 36)];
    self.search.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.search];
    
    
    UITextField *serchTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 274, 36)];
    
    NSLog(@"view frame %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"tableview frame %@", NSStringFromCGRect(self.contentTableView.frame));

    
    UIColor *color = [UIColor whiteColor];
    serchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Szukaj" attributes:@{NSForegroundColorAttributeName: color}];
    
    serchTextField.textColor = [UIColor whiteColor];
    
    [self.search addSubview: serchTextField];
    
    self.contentTableView.backgroundColor = [UIColor clearColor];
    self.contentTableView.frame = CGRectMake(self.contentTableView.frame.origin.x, -150, self.contentTableView.frame.size.width, self.contentTableView.frame.size.height);
    
    self.set_OpenIndex = [[NSMutableSet alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetTableView)
                                                 name:@"resetsideBar"
                                               object:nil];
    [self getCinemasNames];
}
-(void)getCinemasNames{
    self.cinemaNames = [[leftViewModel sharedInstance] getCinemaNames];
}




-(void)resetTableView{
    
  

    [self.contentTableView reloadData];
    NSLog(@"reset");
    [self.view layoutIfNeeded];
    

}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;
    if (currentOffset.y > self.lastContentOffset.y)
    {
        NSLog(@"downward");
        // Downward
    }
    else
    {
        NSLog(@"upward");
        // Upward
    }
    self.lastContentOffset = currentOffset;
}


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
    if (sectionIndex == 0) {
        return 100;
    }
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row % 2 == 0){
        return 16;
    }
    if ([self.expandedPaths containsObject:indexPath]) {
        return 510;
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
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cinemaNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    if ([self.set_OpenIndex containsObject:[NSNumber numberWithInteger:section]]) {
        return 15; // or what ever is the number of rows
    }
    
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];

        label.text = [[leftViewModel sharedInstance] getSideBarCategory];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        
        visualEffectView.frame = view.frame;
        [view addSubview:visualEffectView];
        [view insertSubview:label aboveSubview:view];
        return view;
    }
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    sectionView.backgroundColor = [UIColor colorWithRed:109/255.0 green:40/255.0 blue:104.0/255 alpha:1.0];
    UILabel *sectionName = [[UILabel alloc] initWithFrame:CGRectMake(6, 4, 200, 20)];
    sectionName.text = [self.cinemaNames objectAtIndex:section];
    sectionName.textColor = [UIColor whiteColor];
    [sectionView addSubview:sectionName];
    
    UIButton *headerClick = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    headerClick.tag = section;
    headerClick.backgroundColor = [UIColor clearColor];
    /* Create custom view to display section header... */
    [headerClick addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    headerClick.titleLabel.text = [NSString stringWithFormat:@"headerClick %ld", (long)section];
   
    [sectionView addSubview:headerClick];
    return sectionView;
}

-(void)headerClicked:(UIButton *) sender{

    if ([self.set_OpenIndex containsObject:[NSNumber numberWithUnsignedInteger:sender.tag]]) {
        [self.set_OpenIndex removeObject:[NSNumber numberWithUnsignedInteger:sender.tag]];
        [self.contentTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
    }
    else{
        

        if (self.set_OpenIndex.count > 0) {
            //--- a header is opened already, close the previous one before opening the other
            
            [UIView animateWithDuration:0.5 animations:^{
                [self.set_OpenIndex enumerateObjectsUsingBlock:^(id obj, BOOL *stop){
                    [self.set_OpenIndex removeObject:obj];
                    [self.contentTableView reloadSections:[NSIndexSet indexSetWithIndex:[obj integerValue]] withRowAnimation:UITableViewRowAnimationNone];

                }];
            } completion:^(BOOL finished){

                [self.set_OpenIndex addObject:[NSNumber numberWithUnsignedInteger:sender.tag]];
                [self.contentTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];

            }];
        }
        else{
            [self.set_OpenIndex addObject:[NSNumber numberWithUnsignedInteger:sender.tag]];
            [self.contentTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *firstCellIdentifier = @"firstCell";
    static NSString *separatorCellIdentifier = @"separatorCell";
    static NSString *normalCellIdentifier = @"normalCell";
    static NSString *uncollapsedCellIdentifier = @"uncollapsedCell";


    firstCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier ];
    separatorTableViewCell *separatorCell = [tableView dequeueReusableCellWithIdentifier:separatorCellIdentifier];
    normalTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
    uncollapsedTableViewCell *uncollapsedCell = [tableView dequeueReusableCellWithIdentifier:uncollapsedCellIdentifier];

    
    if (indexPath.row % 2 == 0 ) {
        [tableView registerNib:[UINib nibWithNibName:@"separator" bundle:nil] forCellReuseIdentifier:separatorCellIdentifier];
        separatorCell = [tableView dequeueReusableCellWithIdentifier:separatorCellIdentifier];
        return separatorCell;
    }
    if (indexPath.row % 2 != 0 && ![self.expandedPaths containsObject:indexPath]) {
        [tableView registerNib:[UINib nibWithNibName:@"normalCell" bundle:nil] forCellReuseIdentifier:normalCellIdentifier];
        normalCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        return normalCell;
    }
    if([self.expandedPaths containsObject:indexPath]) {
        [tableView registerNib:[UINib nibWithNibName:@"uncollapsedCell" bundle:nil] forCellReuseIdentifier:uncollapsedCellIdentifier];
        uncollapsedCell = [tableView dequeueReusableCellWithIdentifier:uncollapsedCellIdentifier];
        return uncollapsedCell;

    }
    
    return cell;
}
- (void)changeDay{
    NSLog(@"Dupa kutas cycki");
}

@end
