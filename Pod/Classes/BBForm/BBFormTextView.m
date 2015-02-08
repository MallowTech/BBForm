//
//  BBFormTextView.m
//  Pods
//
//  Created by Ashley Thwaites on 08/02/2015.
//
//

#import "BBFormTextView.h"
#import "BBStyleSettings.h"
#import "PureLayout.h"
#import "PureLayoutDefines.h"
#import "BBExtras-UIView.h"



@implementation BBFormTextViewElement


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)textViewElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
{
    BBFormTextViewElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.delegate = delegate;
    element.placeholderText = placeholderText;
    element.value = value;
    element.originalValue = value;
    return element;
}

@end



@implementation BBFormTextView

-(void)setup
{
    [super setup];
    
    _textview = [[UITextView alloc] initWithFrame:self.bounds];
    _textview.font = [BBStyleSettings sharedInstance].h1Font;
    _textview.delegate = self;
    
    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    
    // here we should use a defined style not colour..
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[BBStyleSettings sharedInstance] seperatorColor].CGColor;
}


-(void)dealloc
{
    [self resignFirstResponder];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    // remove and readd the views to delete the constraints
    [_textview removeFromSuperview];
    [_textview removeConstraints:_textview.constraints];
    [self addSubview:_textview];
    
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_textview])
    {
        [_textview autoPinEdgesToSuperviewEdgesWithInsets:_contentInsets];
    }
    [super updateConstraints];
}


-(void)updateWithElement:(BBFormTextViewElement*)element
{
    self.element = element;
    self.placeholder = element.placeholderText;
    self.text = element.value;
}

- (void)setPlaceholder:(NSString *)placeholder
{
//    [_textfield setPlaceholder:placeholder];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (BOOL)canBecomeFirstResponder
{
    return [_textview canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textview becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textview resignFirstResponder];
}

-(void)setText:(NSString *)text
{
    _textview.text = text;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    // call the delegate to inform of value changed
    self.element.value = textView.text;
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    // call the delegate to inform of value changed
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<BBFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}



-(NSString*)text
{
    return _textview.text;
}


@end