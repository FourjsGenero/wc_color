# :warning: DEPRECATED :warning:

GBC release 5.00.10 included a customisation for a color picker widget. https://4js.com/online_documentation/fjs-gbc-manual-html/#gbc-topics/gbc_whatsnew_50010.html

Also see this Ask-Reuben article https://4js.com/ask-reuben-2/ig-261/ which uses the color picker widget built into most browsers via input type=color

If you don't like either of those color picker widgets, consider usign what you can find here as a third alternative via a Web Component rather than GBC Customisation 

# wc_color
Two color widgets

Color Field
A field used to simply display color of its field value. Also double click will send a zoom event.

Color Selector
Uses https://bgrins.github.io/spectrum/ in a dialogbox to display. Typically called by on action zoom
from the Color Field, or may be called arbitrarily.
