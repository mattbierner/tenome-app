#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate> {
    NSURL* _path;
}

@property (nonatomic, weak) IBOutlet UIWebView* webView;
@property (nonatomic, weak) IBOutlet UIButton* refreshButton;
@property (nonatomic, weak) IBOutlet UIButton* recordButton;

- (IBAction) refresh:(id)sender;

- (IBAction) hitRecordButton:(id)sender;


@end

