//
//  AddReceiptsViewController.m
//  Receipts++
//
//  Created by Anton Moiseev on 2016-05-26.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "AddReceiptsViewController.h"

@interface AddReceiptsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) NSArray *categoriesArray;
@property (strong, nonatomic) NSMutableSet *setOfSelectedCategories;

@end

@implementation AddReceiptsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    self.amountTextField.delegate = self;
    self.noteTextField.delegate = self;
    
    self.categoryTableView.rowHeight = 30;
    
    [self.cancelButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.categoriesArray = @[@"Personal", @"Family", @"Business"];
    self.categoryTableView.allowsMultipleSelection = YES;
    
    self.setOfSelectedCategories = [NSMutableSet new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    cell.textLabel.text = self.categoriesArray[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *headerName;
    if (section == 0) {
        headerName = @"Category";
    }
    return headerName;
}

- (void)buttonTapped:(UIButton *)sender {
    
    if (sender == self.cancelButton) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (sender == self.addButton) {
        AppDelegate *appDel = [UIApplication sharedApplication].delegate;
        Receipt *newReceipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:appDel.managedObjectContext];
        newReceipt.amount = [NSNumber numberWithFloat:[self.amountTextField.text floatValue]];
        newReceipt.note = self.noteTextField.text;
        newReceipt.timeStamp = self.datePicker.date;
        NSMutableArray *arrayOfTagsForReceipt = [NSMutableArray new];
        for (Tag *tag in self.tags) {
            if ([self.setOfSelectedCategories containsObject:tag.tagName]) {
                [arrayOfTagsForReceipt addObject:tag];
            }
        }
        newReceipt.tag = [NSOrderedSet orderedSetWithArray:arrayOfTagsForReceipt];
        [appDel.managedObjectContext save:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self.setOfSelectedCategories addObject:@"Personal"];
    }
    if (indexPath.row == 1) {
        [self.setOfSelectedCategories addObject:@"Family"];
    }
    if (indexPath.row == 2) {
        [self.setOfSelectedCategories addObject:@"Business"];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.setOfSelectedCategories removeObject:@"Personal"];
    }
    if (indexPath.row == 1) {
        [self.setOfSelectedCategories removeObject:@"Family"];
    }
    if (indexPath.row == 2) {
        [self.setOfSelectedCategories removeObject:@"Business"];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end
