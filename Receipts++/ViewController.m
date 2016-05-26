//
//  ViewController.m
//  Receipts++
//
//  Created by Anton Moiseev on 2016-05-26.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "ViewController.h"
#import "AddReceiptsViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSManagedObjectContext *moc;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchTags];
    
    if (self.tags.count == 0) {
        Tag *personalTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.moc];
        personalTag.tagName = @"Personal";
        Tag *familyTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.moc];
        familyTag.tagName = @"Family";
        Tag *businessTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.moc];
        businessTag.tagName = @"Business";
        [self.moc save:nil];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tags.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *header;
    if (section == 0) {
        header = @"Personal";
    }
    if (section == 1) {
        header = @"Family";
    }
    if (section == 2) {
        header = @"Business";
    }
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Tag *ourTag;
    if (section == 0) {
        ourTag = self.tags[0];
    }
    if (section == 1) {
        ourTag = self.tags[1];
    }
    if (section == 2) {
        ourTag = self.tags[2];
    }
    return ourTag.receipt.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Tag *tag = self.tags[indexPath.section];
    Receipt *receipt = [tag.receipt objectAtIndex:indexPath.row];
    cell.textLabel.text = receipt.note;
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addReceipts"]) {
        AddReceiptsViewController *arvc = segue.destinationViewController;
        arvc.tags = self.tags;
    }
}

- (void)fetchTags {
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    self.moc = appDel.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:self.moc];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tagName" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *fetchedTags = [self.moc executeFetchRequest:fetchRequest error:&error];
    self.tags = fetchedTags;
}

@end
