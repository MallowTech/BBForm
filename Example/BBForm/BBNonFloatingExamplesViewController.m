//
//  BBNonFloatingExamplesViewController.m
//  BBForm
//
//  Created by Ashley Thwaites on 07/02/2015.
//  Copyright (c) 2015 Ashley Thwaites. All rights reserved.
//

#import "BBNonFloatingExamplesViewController.h"
#import "BBFormDateField.h"
#import "BBFormSelectField.h"
#import "BBFormTextField.h"
#import "BBFormTextView.h"

@interface BBNonFloatingExamplesViewController () <BBFormElementDelegate>
{
    BBFormTextFieldElement *textFieldElement;
    BBFormSelectFieldElement *selectFieldElement;
    BBFormDateFieldElement *dateFieldElement;
    BBFormTextViewElement *textViewElement;
}

@property (nonatomic, strong) IBOutlet BBFormDateField *dateField;
@property (nonatomic, strong) IBOutlet BBFormSelectField *selectField;
@property (nonatomic, strong) IBOutlet BBFormTextField *textField;
@property (nonatomic, strong) IBOutlet BBFormTextView *textView;

@end

@implementation BBNonFloatingExamplesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textFieldElement = [BBFormTextFieldElement textInputElementWithID:0 placeholderText:@"Question" value:nil delegate:self];
    selectFieldElement = [BBFormSelectFieldElement selectElementWithID:1 labelText:@"Select Option" values:@[@"1 minute",@"5 minutes",@"15 minutes",@"1 hour"] delegate:self];
    dateFieldElement = [BBFormDateFieldElement datePickerElementWithID:2 labelText:@"Enter a date" date:nil datePickerMode:UIDatePickerModeDate delegate:nil];
    textViewElement = [BBFormTextViewElement textViewElementWithID:3 placeholderText:@"Enter some text" value:nil delegate:nil];

    [_textField updateWithElement:textFieldElement];
    [_selectField updateWithElement:selectFieldElement];
    [_dateField updateWithElement:dateFieldElement];
    [_textView updateWithElement:textViewElement];
    
    // we should add some validations to show how that works too..
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // create the model
}

@end
