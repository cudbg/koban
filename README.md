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
    * The same way databases have fixed set of general operators, are there a fixed set of xforms that are "good enough"?
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


Development
==========


The current implementation contains a chrome extension that adds content to the top of
registered webpages, and a backend server that downloads and extracts content to be added.

The user statically implements content extractors in the backend.  For example, if I want
to extract and include the modern love article on the top of the nytimes.com home page, I
need to

1. write an extractor for the modern love page and
2. register the extractor to nytimes.com in the backend

### Requires

* node.js
* coffeescript
* cake
* python + pyquery + requests + flask

### Install

Build chrome extension

    git clone https://github.com/mitdbg/koban.git
    cd koban/chrome
    npm install
    cake build

Install chrome extension

    go to "chrome://extensions" in chrome
    check "developer mode"
    click "load upacked extension" button
    go to 'build' directory (contains manifest.json)

Install server

    cd koban/backend
    pip install pyquery requests flask
    python server.py


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
Open web analytics.  The code is hidden somewhere in listit's [massive repo](http://code.google.com/p/list-it/)

WebScraping

* How is this different than webscraping?

[Mira Dontcheva](http://www.adobe.com/technology/people/san-francisco/mira-dontcheva.html)

* [Attaching UI Enhancements to Websites ](http://research.microsoft.com/pubs/141332/2008chi_reform.pdf)
* [summarizing personal browsing sessions](http://dontcheva.org/pubs/DontchevaUIST06.pdf)

[Boilerpipe](http://www.l3s.de/~kohlschuetter/boilerplate/)
Boilerplate detection and removal.  See [paper](http://www.l3s.de/~kohlschuetter/publications/wsdm187-kohlschuetter.pdf)



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
