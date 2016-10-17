
# Type Director

Type Director is a SASS framework that generates a responsive, modular, nuanced typographic system from only a few key variables.



## Features

1. Modular. Typographic measurements are based on proportional lists of values. 
2. Responsive. Typography adjusts to the unique constraints of each breakpoint.
3. Nuanced. Various properties allow detail-oriented typographers to align additional fonts or uppercase styles to a modular scale.



## Install 

* Terminal: `gem install type-director`
* Compass config.rb: `require 'type-director'`
* SCSS: `@import 'type-director';`

Or create a new project with a sample config and type specimen:

* Terminal: `compass create project-name -r type-director --using type-director`


## Usage

### Declare your typefaces

Typefaces associate a font-family with various typeface-specific adjustments. Define them via SASS maps in the following format:

```scss
$typefaces: (

	// Default typeface
	"georgia": (
		"family": (Georgia, serif),
		"font-size-adjustment": 1.00,
		"line-height-adjustment": 1.00
	),

	// Additional typefaces
	"verdana": (
		"family": (Verdana, sans-serif),
		"font-size-adjustment": 0.89,
		"line-height-adjustment": 0.94
	),

	"feather": (
		"family": ("Feather"),
		"font-size-adjustment": 1.00,
		"line-height-adjustment": 1.00
	)
)
```

Oftentimes two typfaces set to the same font-size do not appear to be. This is because the heights of their lowercase letters are not equal. By using the `font-size-adjustment` property, additional typefaces can be normalized to the default typeface. This will ensure they align to the modular scale.

For example, Verdana appears 11% larger than Georgia. To normalize it with Georgia, we can set a `font-size-adjustment: 0.89`. This will cause Verdana to be 11% smaller than Georgia when set to the same size.

Similarly, you can also apply an adjustment to line-height on a typeface-by-typeface basis by specifying a `line-height-adjustment`.



### Declare your environments

Environments associate media queries with a modular type scale. Define them via SASS maps in the following format:

```scss
$environments: (

	// Phone sizes 
	"phone": (
		"base-font-size": 16px,
		"base-line-height": 1.5,
		"max-font-size": 28px,
		"max-line-height": 1.35
	),

	// Tablet sizes and larger 
	"tablet": (
		"media-query": "screen and (min-width: 768px)",
		"base-font-size": 18px,
		"base-line-height": 1.6,
		"max-font-size": 42px,
		"max-line-height": 1.25
	)
);
```
For each environment, you'll need to specify font-size and line-height for both a base size and a max size. The type scale for each environment will be interpolated from these constraints.

A `media-query` property should also be set for each environment, except for the environment you'd like to be default.



### Build typography

```scss
$typography: td-typography(

	"typefaces": $typefaces,
	"environments": $environments,

	// Other than the base, how many type sizes do you need?
	"numb-smaller-sizes": 1,
	"numb-larger-sizes": 4
);
```

That's it! Note that `$typography` is a key variable. This map will be used by the following mixins to lookup and apply sizes.

If you need a bit of typographic guidance, [Responsive Typography: The Basics](https://ia.net/know-how/responsive-typography-the-basics "Responsive Typography: The Basics") by Information Architects is an excellent read.



### Apply responsize sizing

Use `@include td-responsive-type-size($typface-name, $size)` to apply a responsive size. The type sizes available to you are based on your parameters: 
* 0 is your base size.
* 1, 2, 3... are your increasingly larger sizes.
* -1, -2, -3... are your increasingly smaller sizes.

```scss
.lead {
	@include td-responsive-type-size("georgia", 1);
}
```
We just applied responsive styling to the lead paragraph style. It will use media queries to apply Georgia at size `1` from the corresponding scale: 18.4px for phone, and then resizing to 22.2px for tablets and larger.

```scss
.h4 { 
	@include td-responsive-type-size("verdana", 1);
}
```
We used the same size for the `.h4` heading, but with Verdana. This will result in a font-size of 16.4px for phones and 19.8px for tablets and larger. Mathematically different than Georgia at size `1`, but visually equal.



### Apply static sizing

You might occassionally want finer-grained control of your type styles. For these cases, use the `td-type-size()` mixin which accepts an additional `$environment-name` parameter:

```scss
.h4 { 
	@include td-font-size("verdana", 1, "phone");
	@include td-font-size("verdana", 2, "tablet");
}
```

Here we just applied size 1 for phones and size 2 for tablets. If we had used `td-set-responsive-font-size()` the same size would have been applied for each environment. 


## Advanced Usage

### Rounding 

Rounding to any precision is supported. 

```scss
$environments: (

	"phone": (
		"base-font-size": 16px,
		"base-line-height": 1.5,
		"max-font-size": 28px,
		"max-line-height": 1.35,
		"font-size-precision": 0.1,
		"line-height-precision": 0.01
	),

	// ...
);
```

### Solid and tight line-heights

Oftentimes you may need to set very narrow lines of text, causing your line-height to look too loose. For a tighter line-height, use the `"line-height": "tight"` option.

```scss
.caption-tight { 
	@include td-responsive-type-size("verdana", -1, $opts: ("line-height": "tight"));
}
```

Other times you may want to set text to be solid (meaning no "leading"). In terms of CSS, this setting the line-height to be equal to the font-size. To do this, use the `"line-height": "solid"` option.

```scss
.btn { 
	@include td-responsive-type-size("verdana", 1, $opts: ("line-height": "solid"));
}
```

### Uppercase styles

If you'd like to set something in all caps and have it align to your type scales, include an `uppercase-adjustment` when defining fonts:

```scss
$typefaces: (

	"verdana": (
		"family": (Verdana, sans-serif),
		"font-size-adjustment": 0.89,
		"line-height-adjustment": 0.94,
		"uppercase-adjustment": 0.85
	),

	// ...
)
```

Apply an uppercase style like so:
```scss
.h4 { 
	@include td-responsive-type-size("verdana", 1, $opts: ("uppercase": true));
}
```

