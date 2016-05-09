# Sane Scale

Sane Scale is a framework for defining and applying typographic styles. Its goal is to generate a complex, nuanced typographic system from only a few key variables. 

## Features

1. Modular. Typographic measurements are based on proportional lists of values. 
2. Responsive. Typography adjusts to the constraints of each breakpoint.
3. Font rebalancing. Different fonts set to the same size often don't appear to be. Fonts are normalized, so every font appears to be exactly the size you intend.

## Install 

* Terminal: `gem install sane-scale`
* Compass config.rb: `require 'sane-scale'`
* SCSS: `@import 'sane-scale';`

## Usage

### Declare your fonts

For Sane Scale, fonts are defined via SASS maps in the following format:

```scss
// Default font

$font-georgia: (
	"family": unquote("Georgia, serif"),
	"normalize-ratio": 1.00
); 

// Additional fonts

$font-verdana: (
	"family": unquote("Verdana, sans-serif"),
	"normalize-ratio": 0.89
);
 
$font-feather: (
	"family": unquote("'Feather'"),
	"normalize-ratio": 0.95
);
```

Oftentimes two fonts set to different sizes do not appear to be the same size. This is because the height of their lowercase letters is not equal. The `normalize-ratio` is the ratio we'll use to adjust the size of anything set in this font. 

For example, Verdana appears 11% larger than Georgia. To normalize it with Georgia, we need to decrease size by 11% (normalize-ratio: 0.89). The normalized sizes of Verdana will appear to be the same size as Georgia.

### Define your breakpoints

Sane scale uses a SASS map of breakpoints (with relevant parameters) in the following format:

```scss
$breakpoints: (	

	// Phone sizes
	"default": (
		"base-font-size": 18px,
		"base-line-height": 1.5,
		"max-font-size": 28px,
		"max-line-height": 1.35,
		"rounding": false
	),

	// Tablet sizes and larger
	"tablet": (
		"media-query": "screen and (min-width: 600px)",
		"base-font-size": 20px,
		"base-line-height": 1.6,
		"max-font-size": 42px,
		"max-line-height": 1.25,
		"rounding": false
	)
); 
```
For each breakpoint, you'll need to specify a font-size and line-height for both the base size and the max size. Additional sizes and line-heights will be interpolated from these constraints.

You'll also need to specify a `media-query` for all breakpoints, excluding your `default` breakpoint. Feel free to name the other breakpoints whatever you like.

### Build the scale

All thats left to do is to define the sizes you need and build the scale itself:

```scss
$numb-smaller-sizes: 1;
$numb-larger-sizes: 4;

$sane-scale: ss-make-responsive-font-scale($breakpoints, $numb-smaller-sizes, $numb-larger-sizes);
```
That's it! Note that `sane-scale` is a key variable. This map will be used by the following mixins to lookup and apply sizes.

### Apply responsize sizing

Use `@include ss-set-responsive-font-size($font, $size)` to apply a responsive size. The sizes available to you are based on your parameters: 
* 0 is your base size.
* 1, 2, 3... are your increasingly large sizes.
* -1, -2, -3... are your increasingly small sizes.

```scss
p.lead {
	@include ss-set-responsive-font-size($font-georgia, 1);
}
```
We just created a responsive lead paragraph style. It will use `$font-georgia` at size 1 for each breakpoint: 20.1px by default, and then resizing to 24.1px for tablets and larger.

```scss
.h4 { 
	@include ss-set-responsive-font-size($font-verdana, 1);
}
```
We justed used the same size `.h4` heading, but with `$font-verdana`. That will result in a font-size of 17.9px by default and 21.4px for tablets and larger. Mathematically different, but visually equal.



### Apply static sizing

You might occassionally want finer-grained control of your type styles. For these cases, use the `ss-set-font-size()` mixin which accepts an additional `$breakpoint` parameter:

```scss
.h4 { 
	@include ss-set-font-size($font-verdana, 1, "tablet");
}
```

Here we just styled our h4 to have the size 1 for only the tablet breakpoint. With `ss-set-responsive-font-size()` the corresponding sizes for each other breakpoint would have also been applied.