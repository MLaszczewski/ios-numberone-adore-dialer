
#import "DualButtonView.h"
#import "BottomButtonBar.h"

#define kStdButtonWidth			264.0
#define kStdButtonHeight		48.0  

@implementation DualButtonView

@synthesize delegate;

- (void)preloadButtons
{
  CGRect rect = CGRectMake(10.0f,  30.0f, kStdButtonWidth, kStdButtonHeight);
  UIImage *buttonBackground = [UIImage imageNamed:@"bottombardarkgray.png"];
  UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"bottombardarkgray_pressed.png"];
  
  UIButton *button = [BottomButtonBar createButtonWithTitle:nil
                                                      image:nil
                                                      frame:rect
                                                 background:buttonBackground
                                          backgroundPressed:buttonBackgroundPressed];
  [button setTag:0];
  [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
  _buttons[0] = button;
  [self addSubview:_buttons[0]];
  
  rect = CGRectMake(10.0f,  138.0f, kStdButtonWidth, kStdButtonHeight);
  button = [BottomButtonBar createButtonWithTitle:nil
                                            image:nil
                                            frame:rect
                                       background:buttonBackground
                                backgroundPressed:buttonBackgroundPressed];
  [button setTag:1];
  [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
  _buttons[1] = button;
  [self addSubview:_buttons[1]];
}

- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
    {
      UIImage *background = [UIImage imageNamed:@"waiting.png"];
      self.backgroundColor = [UIColor colorWithPatternImage: background];
      [self preloadButtons];
    }
    return self;
}


/*- (void)drawRect:(CGRect)rect {
    // Drawing code
}*/

- (void)clicked:(UIButton *)button
{
  if ([delegate respondsToSelector:@selector(buttonClicked:)])
  {
    [delegate buttonClicked:[button tag]];
  }
}

- (void)dealloc 
{
  [_buttons[0] release];
  [_buttons[1] release];
  [super dealloc];
}

- (UIButton *)buttonAtPosition:(NSInteger)pos
{
  if (pos < 0 || pos > 1)
    return nil;
  return _buttons[pos];
}

- (void)setTitle:(NSString *)title image:(UIImage *)image forPosition:(NSInteger)pos
{
  if (pos < 0 || pos > 1)
    return;
  if (image)
  {
    [_buttons[pos] setImage:image forState:UIControlStateNormal];
    [_buttons[pos] setImage:image forState:UIControlStateSelected];
  }
  if (title)
  {
    //[_buttons[pos] setFont:[UIFont systemFontOfSize:[UIFont buttonFontSize] - 4.]];
    [_buttons[pos] setTitle:title forState:UIControlStateNormal];
  }
}

@end
