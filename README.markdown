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

The default Ruby.tmbundle's Run and Run Rake Task commands (and all others) are executed through the default Ruby 1.8 interpreter. Instead, we want MacRuby files to be run through `macruby` instead.

This bundle also attempts to upgrade all of TextMate's `Support/lib/*.rb` files and many of the Ruby.tmbundle's Commands to work with MacRuby. This means:

* using `macruby` instead of `ruby` as `$TM_RUBY`
* cleaning up `Support/lib` code to be ruby1.9 compliant (TextMate's `Support` folder has been copied into bundle as `SharedSupport` folder)
* fixing plist.bundle for ruby1.9

Currently Cmd+R (Run) and Ctrl+Shift+R (Run Rake Task) have been attempted, but both are failing.

Authors
=======

Dr Nic Williams, [drnicwilliams@gmail.com](mailto:drnicwilliams@gmail.com), [http://drnicwilliams.com](http://drnicwilliams.com), [Mocra](http://mocra.com)