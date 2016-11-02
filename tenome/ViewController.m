#import "ViewController.h"
#import "ASScreenRecorder.h"

NSString* const tenomeUrl = @"tenomeUrl";
NSString* const defaultUrl = @"http://192.168.1.6:8080/test.html";

@implementation ViewController

@synthesize webView;
@synthesize recordButton;
@synthesize refreshButton;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [webView.scrollView setScrollEnabled:NO];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.delaysTouchesBegan = YES;
    [self.webView addGestureRecognizer:tapGesture];
}


- (void) viewDidAppear:(BOOL)animated {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Viewer Url"
        message:nil
        preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        NSString* path = alert.textFields[0].text;
        
        [[NSUserDefaults standardUserDefaults] setObject:path forKey:tenomeUrl];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [webView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:path]]];
    }]];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        NSString* url = [[NSUserDefaults standardUserDefaults] stringForKey:tenomeUrl];
        if (url == NULL) {
            url = defaultUrl;
        }
        textField.text = url;
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction) refresh:(id)sender {
    [webView reload];
}

- (IBAction) hitRecordButton:(id)sender {
    ASScreenRecorder *recorder = [ASScreenRecorder sharedInstance];
    if (!recorder.isRecording) {
        refreshButton.hidden = YES;
        recordButton.hidden = YES;
        [recorder startRecording];
    }
}

- (void) onDoubleTap:(UIGestureRecognizer*)recognizer {
    ASScreenRecorder *recorder = [ASScreenRecorder sharedInstance];
    if (!recorder.isRecording) {
        return;
    }
    
    [recorder stopRecordingWithCompletion:^{
        refreshButton.hidden = NO;
        recordButton.hidden = NO;
    }];
}


@end
