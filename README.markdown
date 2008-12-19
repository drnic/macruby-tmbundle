MacRuby TextMate bundle
--------------------

Installation
============

To install via Git:

    cd ~/"Library/Application Support/TextMate/Bundles/"
    git clone git://github.com/drnic/macruby-tmbundle.git "MacRuby.tmbundle"
    osascript -e 'tell app "TextMate" to reload bundles'

Source can be viewed or forked via GitHub: [http://github.com/drnic/macruby-tmbundle/tree/master](http://github.com/drnic/macruby-tmbundle/tree/master)

MacRuby & Ruby 1.9 support
==========================

This bundle also attempts to upgrade all of TextMate's `Support/lib/*.rb` files and many of the Ruby.tmbundle's Commands to work with MacRuby. This means:

* using `macruby` instead of `ruby` as `$TM_RUBY`
* cleaning up `Support/lib` code to be ruby1.9 compliant (TextMate's `Support` folder has been copied into bundle as `SharedSupport` folder)
* fixing plist.bundle for ruby1.9

Currently Cmd+R (Run) and Ctrl+Shift+R (Run Rake Task) have been attempted, but both are failing.

Authors
=======

Dr Nic Williams, [drnicwilliams@gmail.com](mailto:&#x64;&#x72;&#x6E;&#x69;&#x63;&#x77;&#x69;&#x6C;&#x6C;&#x69;&#x61;&#x6D;&#x73;&#x40;&#x67;&#x6D;&#x61;&#x69;&#x6C;&#x2E;&#x63;&#x6F;&#x6D;), [http://drnicwilliams.com](http://drnicwilliams.com), [Mocra](http://mocra.com)