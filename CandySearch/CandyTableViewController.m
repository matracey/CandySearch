//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by Martin Tracey on 02/05/2013.
//  Copyright (c) 2013 Martin Tracey. All rights reserved.
//

#import "CandyTableViewController.h"
#import "Candy.h"

@interface CandyTableViewController () <UISearchBarDelegate, UISearchDisplayDelegate>
@property IBOutlet UISearchBar *candySearchBar;
@property (strong, nonatomic) NSMutableArray *filteredModel;
@end

@implementation CandyTableViewController
@synthesize model;
@synthesize candySearchBar;
@synthesize filteredModel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Sample Data
    model = @[[Candy candyOfCategory:@"chocolate" name:@"chocolate bar"],
              [Candy candyOfCategory:@"chocolate" name:@"chocolate chip"],
              [Candy candyOfCategory:@"chocolate" name:@"dark chocolate"],
              [Candy candyOfCategory:@"hard" name:@"lollipop"],
              [Candy candyOfCategory:@"hard" name:@"candy cane"],
              [Candy candyOfCategory:@"hard" name:@"jaw breaker"],
              [Candy candyOfCategory:@"other" name:@"caramel"],
              [Candy candyOfCategory:@"other" name:@"sour chew"],
              [Candy candyOfCategory:@"other" name:@"peanut butter cup"],
              [Candy candyOfCategory:@"other" name:@"gummi bear"]];
    
    [self.tableView reloadData];
    
    self.filteredModel = [NSMutableArray arrayWithCapacity:model.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return filteredModel.count;
    }else return model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Candy *candy = nil;
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        candy = [filteredModel objectAtIndex:indexPath.row];
    }else candy = [model objectAtIndex:indexPath.row];
    
    cell.textLabel.text = candy.name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - UITableViewSearch
- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    [self.filteredModel removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
    self.filteredModel = [NSMutableArray arrayWithArray:[model filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayControllerDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

@end
