
# Sane Scale

Sane Scale is a SASS framework for defining and applying typographic styles. Its goal is to generate a complex, nuanced typographic system from only a few key variables. 



## Features

1. Modular. Typographic measurements are based on proportional lists of values. 
2. Responsive. Typography adjusts to the constraints of each breakpoint.
3. Font rebalancing. Different fonts set to the same size often don't appear to be. Fonts are normalized, so every font appears to be exactly the size you intend.



## Install 

* Terminal: `gem install sane-scale`
* Compass config.rb: `require 'sane-scale'`
* SCSS: `@import 'sane-scale';`

With a sample configuration and type specimen:

* Terminal: `compass create project-name -r sane-scale --using sane-scale`


## Usage

### Declare your fonts

Fonts are defined via SASS maps in the following format:

```scss
// Default font

$font-georgia: (
	"family": unquote("Georgia, serif"),
	"font-size-adjustment": 1.00,
	"line-height-adjustment": 1.00
);

// Additional fonts

$font-verdana: (
	"family": unquote("Verdana, sans-serif"),
	"font-size-adjustment": 0.89,
	"line-height-adjustment": 0.93
);
 
$font-feather: (
	"family": unquote("'Feather'"),
	"font-size-adjustment": 0.95,
	"line-height-adjustment": 1.00
);
```

Oftentimes two fonts set to the same size do not appear to be. This is because the heights of their lowercase letters are not equal. By using the `font-size-adjustment` property, additional fonts can be normalized to the default font. This will ensure they align to the modular scale.

As an example, Verdana appears 11% larger than Georgia. To normalize it with Georgia, we can set a `normalize-ratio: 0.89`. This will cause Verdana to be 11% smaller than Georgia when both are set to the same size.

Similarly, you may also want to apply an adjustment to line-heights on a font-by-font basis. Specify a `line-height-adjustment` adjustment to do so.



### Define your font scales

Font scales are defined via SASS maps in the following format:

```scss
$font-scales: (	

	// Phone sizes. 
	"default": (
		"base-font-size": 18px,
		"base-line-height": 1.5,
		"max-font-size": 28px,
		"max-line-height": 1.35,
		"round-under": 0px
	),

	// Tablet sizes and larger. 
	"tablet": (
		"media-query": "screen and (min-width: 600px)",
		"base-font-size": 16px,
		"base-line-height": 1.6,
		"max-font-size": 42px,
		"max-line-height": 1.25,
		"round-under": 0px
	)
); 
```
For each scale, you'll need to specify a font-size and line-height for both the base size and the max size. Additional font-sizes and line-heights will be interpolated from these constraints.

A `media-query` property should also be set for each, exluding the default scale. Feel free to name the other scales whatever you like.

If you need a bit of typographic guidance, [Responsive Typography: The Basics](https://ia.net/know-how/responsive-typography-the-basics "Responsive Typography: The Basics") by Information Architects is an excellent read.


### Build the scale

All thats left to do is to define the sizes you need and build the scale itself:

```scss
$numb-smaller-sizes: 1;
$numb-larger-sizes: 4;

$typography: ss-build-typography($font-scales, $numb-smaller-sizes, $numb-larger-sizes);
```
That's it! Note that `$typography` is a key variable. This map will be used by the following mixins to lookup and apply sizes.



### Apply responsize sizing

Use `@include ss-set-responsive-font-size($font, $size)` to apply a responsive size. The sizes available to you are based on your parameters: 
* 0 is your base size.
* 1, 2, 3... are your increasingly larger sizes.
* -1, -2, -3... are your increasingly smaller sizes.

```scss
.lead {
	@include ss-set-responsive-font-size($font-georgia, 1);
}
```
We just applied responsive styling to the lead paragraph style. It will use media queries to apply `$font-georgia` at size `1` from the corresponding scale: 18.4px by default, and then resizing to 22.2px for tablets and larger.

```scss
.h4 { 
	@include ss-set-responsive-font-size($font-verdana, 1);
}
```
We used the same size for the `.h4` heading, but with `$font-verdana`. That will result in a font-size of 16.4px by default and 19.8px for tablets and larger. Mathematically different, but visually equal.



### Apply static sizing

You might occassionally want finer-grained control of your type styles. For these cases, use the `ss-set-font-size()` mixin which accepts an additional `$breakpoint` parameter:

```scss
.h4 { 
	@include ss-set-font-size($font-verdana, 1, "tablet");
}
```

Here we just styled our h4 to have the size 1 for only the tablet breakpoint. With `ss-set-responsive-font-size()` the corresponding sizes for each other breakpoint would have also been applied.
