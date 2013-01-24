Koban
=====

*koban structural optimizer* is a tool to personalize web-navigation on a
per-user basis.


Current mishmash of ideas

1. Model website as a single DOM graph structure
    * Edges would either be DOM parent-child relationships, or AHREF links
    * User browsing sessions are paths through the graph (clicks, reading content, etc)
    * Look for ways of restructuring/adding edges to minimize expected browsing sessions
1. Identify the "predictable" content (e.g., image, article snippet, paragraph) that users are searching for
   present it earlier in user's web browsing session
1. Identify content spread across multiple pages or hierarchy of links, e.g., pagination and collect content into one place
1. In general, identify common data structures embeded within or across pages (e.g., lists, trees) and allow reorganizing the data items
1. Retarget extracted content into filetype-specific optimized templates (think readability or image gallery)
1. CTS can be used as mechanism.  Automatically generate CTS transformations


Use Cases
=========

1. Comics reading: identify chapter of comics I am reading, identify pagination, and construct a gallery of the chapter's 10-20 images
1. TIG: tig.csail is an information hub, however users only go for printing, afs info, room booking, so add links directly to that information
1. Area 2 website is a huge page of words.  However I am only interested in thesis proposal forms and TQE requirements.  Directly move that info to the top/add prominent links.
1. webmail.csail page is simply a redirect to the /horde login page.  Move login form onto the landing page
1. Dropbox landing page hides login form behind a tiny link.  Move the form to a prominent location
1. Amazon product page is a list of sections (e.g., reviews, product details, etc). I always skip sections and read other sections.  Push the reviews up to the top of the page


Related Work
========

Contextual Bookmarks

* Show content snippets/content bookmarks depending on previous browsing sessions
* http://code.google.com/p/reco-gnizr/

[Webwatcher](http://www.cs.cmu.edu/~webwatcher/)
Highlights links that user is likely to interact with


[Bricolage](http://hci.stanford.edu/research/bricolage/)
Construct content alignment between multiple pages

[WebMantage](http://research.microsoft.com/en-us/um/people/horvitz/montage.htm)

[EyeBrowse](http://eyebrowse.csail.mit.edu/)
Open web analytics

WebScraping

* How is this different than webscraping?



Research Quesions
=====

1. Can we even predict [links, content] that user will [click, view]?  User eyebrowse dataset as proof of concept
1. Is it possible to compute the confidence in a given suggested content/bookmark?
1. How to deal with slightly-less-static websites?
1. How to present identified content?
    * add bookmark Links at the top
    * Separate iGoogle-style page/sidebar
    * Toggle "optimized browsing" mode that reformats the page
    * How to distinguish moved content from existing content?
1. Possible metric is *information consumed / minute*.  If Koban works, then expect
   users to consume more information per unit time
