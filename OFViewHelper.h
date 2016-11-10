//
//  OFViewHelper.h
//
//  Created by Oliver Franke on 17.04.14.
//  Copyright (c) 2014 Oliver Franke. All rights reserved.
//

#import <UIKit/UIKit.h>

enum FrameFlatMode
{
    kPureFlat       = 1,
    kDownFlat       = 2,
    kUpFlat         = 3,
    kAvoidUnderNull = 4
    
} typedef FrameFlatMode;

//----------------------------------------------------------------------
@interface OFViewHelper : NSObject
//----------------------------------------------------------------------


//M
//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
                   toSize:(CGSize)size;
+ (void)changeFrameOfView:(UIView *)view
                  toWidth:(CGFloat)width;
+ (void)changeFrameOfView:(UIView *)view
                 toHeight:(CGFloat)height;
+ (void)changeFrameOfView:(UIView *)view
                  toWidth:(CGFloat)width
                andHeight:(CGFloat)height;
+ (void)changeFrameOfView:(UIView *)view
                 toOrigin:(CGPoint)origin;
+ (void)changeFrameOfView:(UIView *)view
              toXPosition:(CGFloat)xPos;
+ (void)changeFrameOfView:(UIView *)view
              toYPosition:(CGFloat)yPos;

+ (void)addHeight:(CGFloat)value toView:(UIView *)view;
+ (void)addWidth:(CGFloat)value toView:(UIView *)view;
+ (void)addXMargin:(CGFloat)value toView:(UIView *)view;
+ (void)addYMargin:(CGFloat)value toView:(UIView *)view;

+ (void)arrangeView:(UIView *)view
          underView:(UIView *)upperView
         withMargin:(CGFloat)margin;
+ (void)arrangeView:(UIView *)view
           overView:(UIView *)upperView
         withMargin:(CGFloat)margin;
+ (void)arrangeView:(UIView *)view
        rightToView:(UIView *)upperView
         withMargin:(CGFloat)margin;
+ (void)arrangeView:(UIView *)view
         leftToView:(UIView *)upperView
         withMargin:(CGFloat)margin;

+ (void)rightAlignView:(UIView *)view
 inSuperViewWithMargin:(CGFloat)margin;
+ (void)bottomAlignView:(UIView *)view
  inSuperViewWithMargin:(CGFloat)margin;

+ (void)rightBottomCornerAlignView:(UIView *)view
             inSuperViewWithMargin:(CGFloat)margin;
+ (void)leftBottomCornerAlignView:(UIView *)view
            inSuperViewWithMargin:(CGFloat)margin;
+ (void)rightTopCornerAlignView:(UIView *)view
          inSuperViewWithMargin:(CGFloat)margin;
+ (void)leftTopCornerAlignView:(UIView *)view
         inSuperViewWithMargin:(CGFloat)margin;


// fiiting in
+ (void)horizontalFitView:(UIView *)view
              betweenLeft:(UIView *)leftView
                 andRight:(UIView *)rightView
               withMargin:(CGFloat)margin;

+ (void)verticalFitView:(UIView *)view
             betweenTop:(UIView *)upperView
              andBottom:(UIView *)underView
             withMargin:(CGFloat)margin;

+ (void)verticalFitView:(UIView *)view
             betweenTop:(UIView *)upperView
              andBottom:(UIView *)underView
          withTopMargin:(CGFloat)marginToTop
        andBottomMargin:(CGFloat)marginToBottom;

+ (void)horizontalCenterViewInSuperView:(UIView *)view
                          addLeftMargin:(CGFloat)leftMargin;

+ (void)verticalCenterViewInSuperView:(UIView *)view
                         addTopMargin:(CGFloat)topMargin;

+ (void)verticalCenterViewInSuperViewUntouched:(UIView *)view
                                  addTopMargin:(CGFloat)topMargin;

+ (void)horizontalCenterView:(UIView *)view
              realtiveToView:(UIView *)relatedView
               addLeftMargin:(CGFloat)leftMargin;
+ (void)verticalCenterView:(UIView *)view
            realtiveToView:(UIView *)relatedView
              addTopMargin:(CGFloat)topMargin;
+ (void)verticalTopView:(UIView *)view
            realtiveToView:(UIView *)relatedView
              addTopMargin:(CGFloat)topMargin;

// check device properties
+ (BOOL)isRetina;
+ (BOOL)isiPhone4InchScreen;
+ (CGFloat)displayScaleFactor;
+ (NSString*)imageScaleSuffix;


// iPhone 5 fixes
+ (void)fixPositionOfView:(UIView *)view
   foriPhone4InchAtBottom:(BOOL)bottom; // bottom if the view is at the bottom line, otherwise it will be centered
+ (void)fixPositionOfManyViews:(NSArray *)views
        foriPhone4InchAtBottom:(BOOL)bottom;

+ (void)stretchView:(UIView *)view
 foriPhone4InchFull:(BOOL)full;

+ (void)stretchManyViews:(NSArray *)views
      foriPhone4InchFull:(BOOL)full;

+ (NSString *)imageNameForDevice:(NSString *)orgImgName; // adding -568h@2x if iPhone 4 Inch
// orgImgName is with or without .png

+ (CGRect)imageFrameOfImageInImageView:(UIImageView *)iv;

//resize the imageview to its actual imagesize
+ (void)sizeImageviewToImageBounds:(UIImageView *)iv;

+ (void)sizeImageviewToImageBounds:(UIImageView *)iv
                       withPadding:(CGSize)padding;

// layer
+ (void)drawShadowOnView:(UIView *)view withRadius:(CGFloat)radius;
+ (void)removeShadowFromView:(UIView *)view;
+ (void)updateShadowFrameOnView:(UIView *)view;
//----------------------------------------------------------------------


+ (void)sizeLabelToCorrectValue:(UILabel*)labelToSize forWidth:(BOOL)isWidth withPadding:(NSInteger)padding;
+ (void)sizeLabelWithAttributedStringToCorrectValue:(UILabel*)labelToSize forWidth:(BOOL)isWidth withPadding:(NSInteger)padding;
+ (void)sizeButtonToCorrectValue:(UIButton*)buttonToSize forWidth:(BOOL)isWidth;
//UILabel
+ (CGFloat)calculateLabelHeightWithWidth:(CGFloat)availableWidth
                                 andText:(NSString *)text
                            andLabelFont:(UIFont *)font;

+ (CGFloat)calculateLabelWitdhWithHeight:(CGFloat)availableHeight
                                 andText:(NSString *)text
                            andLabelFont:(UIFont *)font;

+ (CGFloat)calculateAttributedLabelHeightWithWidth:(CGFloat)availableWidth
                                           andText:(NSAttributedString *)text;

+ (CGFloat)compareFont:(UIFont*)font1
                  with:(UIFont*)font2;

+ (CGFloat)calculateNeededHeightForUnscaledImagesForWidth:(CGFloat)width andImage:(UIImage*)image;
+ (CGFloat)calculateNeededHeightForUnscaledImagesForWidth:(CGFloat)width andImageDimensions:(CGSize)size;
+ (CGRect)adaptFrameSizeOnDeviceSize:(CGRect)frameToFit;
+ (CGFloat)scaleToMaxHeightAndSizeForScreen:(CGSize)sizeOfObject;
+ (BOOL)doesString:(NSString*)string
      fitWithWidth:(NSInteger)width
        baseOnFont:(UIFont*)font;
/**
 *  Will cast all values to Integer for better renderings
 *
 *  @param frame The frame you want to flat
 *  @param mode FrameFlatMode to detail adjust what to do
 *  @return flatted frame
 */
+ (CGRect)flatFrame:(CGRect)frame option:(FrameFlatMode)mode;

+ (void)sizeScrollview:(UIScrollView*)scrollView
         toThisElement:(UIView*)view
               padding:(NSInteger)pading;

@end
