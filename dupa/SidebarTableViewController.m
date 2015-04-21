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
#import "cinemaTableViewCell.h"
#import "clubTableViewCell.h"

#define Category_Box_Height 72
#define Category_Subclass_Height 36
#define Category_Object_Height 152


@interface SidebarTableViewController ()

@property (nonatomic, strong) NSMutableArray *expandedPaths;
@property (nonatomic, strong) NSMutableSet *set_OpenIndex;
@property (nonatomic, strong) NSArray *cinemaNames;
@property (nonatomic, strong) NSArray *clubNames;

@property (nonatomic, strong) UIView *scrollSearchBar;
@property (assign, nonatomic) CGPoint lastContentOffset;
@property (nonatomic, strong) NSString *categoryName;



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
    
    // Adjusting tableView
    
    self.search = [[UIView alloc] initWithFrame:CGRectMake(8, 8, 274, 36)];
    self.search.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.search];
    
    UITextField *serchTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 274, 36)];
    
    UIColor *color = [UIColor whiteColor];
    serchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Szukaj" attributes:@{NSForegroundColorAttributeName: color}];
    
    serchTextField.textColor = [UIColor whiteColor];
    
    [self.search addSubview: serchTextField];
    
    self.contentTableView.backgroundColor = [UIColor clearColor];
    self.contentTableView.frame = CGRectMake(self.contentTableView.frame.origin.x, -150, self.contentTableView.frame.size.width, self.contentTableView.frame.size.height);
    
    self.contentTableView.rowHeight = UITableViewAutomaticDimension;

    
    // open tableViewCells
    
    self.set_OpenIndex = [[NSMutableSet alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetTableView)
                                                 name:@"resetsideBar"
                                               object:nil];
    // Get data for sections
    
    [self getCinemasNames];
    [self getClubNames];
    // scrollSearchBar
    
    self.scrollSearchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    self.scrollSearchBar.hidden = YES;
    self.scrollSearchBar.backgroundColor = [UIColor whiteColor];
    
    // setCategoryName
    
    

    
}
-(void)getCinemasNames{
    self.cinemaNames = [[leftViewModel sharedInstance] getCinemaNames];
}

-(void)getClubNames{
    self.clubNames = [[leftViewModel sharedInstance] getClubNames];
}


-(void)resetTableView{
    
  

    [self.contentTableView reloadData];
    [self.expandedPaths removeAllObjects];
    [self.set_OpenIndex removeAllObjects];
    NSLog(@"reset");
    [self.view layoutIfNeeded];
    

}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;

    
    if (currentOffset.y > self.lastContentOffset.y)
    {
//        NSLog(@"downward %f", currentOffset.y);
        if(currentOffset.y > -20){
            self.search.hidden = YES;
        }
        self.scrollSearchBar.hidden = YES;
        // Downward
    }
    else
    {
//        NSLog(@"upward %f", currentOffset.y);
        [self.view addSubview:self.scrollSearchBar];
        self.scrollSearchBar.hidden = NO;

        if(currentOffset.y < -63){
            self.search.hidden = NO;
            self.scrollSearchBar.hidden = YES;
        }
        
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
        return 72;
    }
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    self.categoryName = [[leftViewModel sharedInstance] getSideBarCategory];
    
    if (indexPath.row % 2 == 0){
        return 8;
    }

    if ([self.expandedPaths containsObject:indexPath]) {
        return 510;
    }
    if ([self.categoryName isEqualToString:@"cinema"]) {
        return 72;
    }

    return 190;
    
    // if normal return 190
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
    self.categoryName = [[leftViewModel sharedInstance] getSideBarCategory];
    
    if([self.categoryName isEqualToString:@"cinema"]){
        return self.cinemaNames.count;
    }
    if ([self.categoryName isEqualToString:@"club"]) {
         return self.clubNames.count;
    }
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    if ([self.set_OpenIndex containsObject:[NSNumber numberWithInteger:section]]) {
        return 16; // or what ever is the number of rows
    }
    
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.categoryName = [[leftViewModel sharedInstance] getSideBarCategory];
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 72)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 26, tableView.frame.size.width, 18)];

        label.text = [[leftViewModel sharedInstance] getSideBarCategory];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:@"Roboto-Light" size:24.f];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        
        visualEffectView.frame = view.frame;
        if ([self.categoryName isEqualToString:@"club"]) {
            
            view.backgroundColor = [UIColor colorWithRed:83/255.0 green:68/255.0 blue:148/255.0 alpha:0.35];
            
        }else{
        
            view.backgroundColor = [UIColor colorWithRed:109/255.0 green:40/255.0 blue:104.0/255.0 alpha:0.15];
        
        }
        
        [view addSubview:visualEffectView];
        [view insertSubview:label aboveSubview:view];
        return view;
    }
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    UILabel *sectionName = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, 200, 20)];

    
    if ([self.categoryName isEqualToString:@"club"]) {
        
        sectionName.text = [self.clubNames objectAtIndex:section];
        sectionView.backgroundColor = [UIColor colorWithRed:83/255.0 green:68/255.0 blue:148.0/255.0 alpha:1.0];
        
    }else{
        
        sectionName.text = [self.cinemaNames objectAtIndex:section];
        sectionView.backgroundColor = [UIColor colorWithRed:109/255.0 green:40/255.0 blue:104.0/255 alpha:1.0];
        
    }
    
    sectionName.textColor = [UIColor whiteColor];
    sectionName.font = [UIFont fontWithName:@"Roboto-Light" size:16.f];
    [sectionView addSubview:sectionName];
    
//    83 68 148           - kluby
//    209 178 132         - kawa
//    78 194 198          - sport
    
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
    
    NSLog(@"dupeczka %f", self.delegate.view.frame.origin.x);
    if (self.delegate.view.frame.origin.x == 0) {
    
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *firstCellIdentifier        = @"firstCell";
    static NSString *separatorCellIdentifier    = @"separatorCell";
    static NSString *normalCellIdentifier       = @"normalCell";
    static NSString *uncollapsedCellIdentifier  = @"uncollapsedCell";
    static NSString *cinemaCellIdentifier       = @"cinemaCell";
    static NSString *clubCellIdentifier         = @"clubCell";


    firstCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier ];
    separatorTableViewCell *separatorCell = [tableView dequeueReusableCellWithIdentifier:separatorCellIdentifier];
    normalTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
    uncollapsedTableViewCell *uncollapsedCell = [tableView dequeueReusableCellWithIdentifier:uncollapsedCellIdentifier];
    cinemaTableViewCell *cinemaTableViewCell = [tableView dequeueReusableCellWithIdentifier:cinemaCellIdentifier];
    clubTableViewCell *clubTableViewCell = [tableView dequeueReusableCellWithIdentifier:clubCellIdentifier];
    
    if (indexPath.row % 2 == 0 ) {
        [tableView registerNib:[UINib nibWithNibName:@"separator" bundle:nil] forCellReuseIdentifier:separatorCellIdentifier];
        separatorCell = [tableView dequeueReusableCellWithIdentifier:separatorCellIdentifier];
        return separatorCell;
    }

    if (indexPath.row % 2 != 0 && ![self.expandedPaths containsObject:indexPath] && [self.categoryName isEqualToString:@"cinema"]) {
        [tableView registerNib:[UINib nibWithNibName:@"cinemaTableViewCell" bundle:nil] forCellReuseIdentifier:cinemaCellIdentifier];
        cinemaTableViewCell = [tableView dequeueReusableCellWithIdentifier:cinemaCellIdentifier];
        return cinemaTableViewCell;
        
    }else if (indexPath.row % 2 != 0 && ![self.expandedPaths containsObject:indexPath] && [self.categoryName isEqualToString:@"club"]){
            [tableView registerNib:[UINib nibWithNibName:@"clubCell" bundle:nil] forCellReuseIdentifier:clubCellIdentifier];
            clubTableViewCell = [tableView dequeueReusableCellWithIdentifier:clubCellIdentifier];
            return clubTableViewCell;
        }else if (indexPath.row % 2 != 0 && ![self.expandedPaths containsObject:indexPath]){
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
}

@end
