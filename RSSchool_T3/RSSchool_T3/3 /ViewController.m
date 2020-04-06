#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) UILabel *labelGreen;
@property (nonatomic, strong) UILabel *labelBlue;
@property (nonatomic, strong) UILabel *labelResultColor;

@property (nonatomic, strong) UIButton *buttonProcess;

@property (nonatomic, strong) UITextField *textFieldRed;
@property (nonatomic, strong) UITextField *textFieldGreen;
@property (nonatomic, strong) UITextField *textFieldBlue;

@property (nonatomic, strong) UIView *viewResultColor;

@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //MARK: -> Labels
    
    CGRect forLabelResultColor = CGRectMake(20, 100, 100, 40);
    CGRect forLabelRed = CGRectMake(20, 160, 80, 40);
    CGRect forLabelGreen = CGRectMake(20, 220, 80, 40);
    CGRect forLabelBlue = CGRectMake(20, 280, 80, 40);
    
    self.labelResultColor = [[UILabel alloc] initWithFrame:forLabelResultColor];
    self.labelRed = [[UILabel alloc] initWithFrame:forLabelRed];
    self.labelGreen = [[UILabel alloc] initWithFrame:forLabelGreen];
    self.labelBlue = [[UILabel alloc] initWithFrame:forLabelBlue];
    
    self.labelResultColor.text = @"Color";
    self.labelRed.text = @"RED";
    self.labelGreen.text = @"GREEN";
    self.labelBlue.text = @"BLUE";
    
    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.labelBlue];
    
    //MARK: -> TextFields
    
    CGRect forTextFieldRed = CGRectMake(120, 160, 250, 40);
    CGRect forTextFieldGreen = CGRectMake(120, 220, 250, 40);
    CGRect forTextFieldBlue = CGRectMake(120, 280, 250, 40);
    
    self.textFieldRed = [[UITextField alloc] initWithFrame:forTextFieldRed];
    self.textFieldGreen = [[UITextField alloc] initWithFrame:forTextFieldGreen];
    self.textFieldBlue = [[UITextField alloc] initWithFrame:forTextFieldBlue];
    
    self.textFieldRed.placeholder = @"0..255";
    self.textFieldGreen.placeholder = @"0..255";
    self.textFieldBlue.placeholder = @"0..255";
    
    self.textFieldRed.borderStyle= UITextBorderStyleRoundedRect;
    self.textFieldGreen.borderStyle= UITextBorderStyleRoundedRect;
    self.textFieldBlue.borderStyle= UITextBorderStyleRoundedRect;
    
    [self.view addSubview:self.textFieldRed];
    [self.view addSubview:self.textFieldGreen];
    [self.view addSubview:self.textFieldBlue];
    
    [self.textFieldRed addTarget:self action:@selector(startTyping:) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldGreen addTarget:self action:@selector(startTyping:) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldBlue addTarget:self action:@selector(startTyping:) forControlEvents:UIControlEventAllTouchEvents];
    
    self.textFieldRed.delegate = self;
    self.textFieldGreen.delegate = self;
    self.textFieldBlue.delegate = self;
    
    //MARK: -> View
    
    CGRect forViewResultColor = CGRectMake(140, 100, 230, 40);
    self.viewResultColor = [[UIView alloc] initWithFrame:forViewResultColor];
    self.viewResultColor.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.viewResultColor];
    
    //MARK: -> Button
    
    CGRect forButtonProcess = CGRectMake(self.view.bounds.size.width / 2 - 40, 360, 80, 40);
    self.buttonProcess = [[UIButton alloc] initWithFrame:forButtonProcess];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.view addSubview:self.buttonProcess];
    [self.buttonProcess addTarget:self action:@selector(tappedButtonProcess) forControlEvents:UIControlEventTouchUpInside];
    
    //MARK: -> Accessibility Identifier
    
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

//MARK: -> Button Action
- (void)tappedButtonProcess {
    
    if ([self isTextFieldValid:self.textFieldRed] && [self isTextFieldValid:self.textFieldGreen] && [self isTextFieldValid:self.textFieldBlue]) {
        
        double redValue = [self.textFieldRed.text doubleValue];
        double greenValue = [self.textFieldGreen.text doubleValue];
        double blueValue = [self.textFieldBlue.text doubleValue];
        
        UIColor *resultColor = [UIColor colorWithRed:redValue/255 green:greenValue/255 blue:blueValue/255 alpha:1.0];
        
        self.viewResultColor.backgroundColor = resultColor;
        self.labelResultColor.text = [self hexStringFromColor:resultColor];
        
    } else {
        self.labelResultColor.text = @"Error";
    }
    
    [self.view endEditing:YES];
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
}

//MARK: -> Validation Check

- (BOOL)isTextFieldValid:(UITextField *)textField {
    
    NSCharacterSet *charactersCheck = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    NSRange badRange = [textField.text rangeOfCharacterFromSet:charactersCheck];
    if (badRange.location != NSNotFound) {
        return NO;
    }
    
    int valueFromTextField = [textField.text intValue];
    
    if ([textField.text isEqualToString:@""] || valueFromTextField < 0 || valueFromTextField > 255) {
        return NO;
    }
    
    return YES;
}

- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"0x%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

- (void)startTyping:(UITextField *)textField {
    
    self.labelResultColor.text = @"Color";
    self.viewResultColor.backgroundColor = UIColor.grayColor;
    
}

@end
