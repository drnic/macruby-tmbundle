---
layout: post
title: Running MacRuby inside TextMate
---

In normal Ruby files, Cmd+R will run the ruby script and output any STDOUT to an HTML-based window. If the file is a MacRuby script, then we want it to run through `macruby` instead.

My initial attempt was to clone over the Ruby.tmbundle's Run command, and all its Support files, change $TM_RUBY from `ruby` to `macruby` and watch awesomeness unfold.

Unfortunately, awesomeness had to wait. The ruby files had some ruby 1.9 incompatibilities. So I fixed those (no more $KCODE, etc). Then big challenges were discovered. There are ruby 1.9 incompatibilities, and perhaps macruby incompatibilities within TextMate's own Support folder.

My initial attempt to start fixing them has been to pull in TextMate's own Support folder into this bundle as a SharedSupport folder. We can now hack away at it and attempt to get this working.

I found an issue with osx/plist.bundle. On my local machine I pulled down the plist.bundle source which apparently has a ruby 1.9 fix in it, rebuilt it and added it back into the bundle. But it still fails. In fact, the plist.bundle src's own tests are currently failing for ruby1.9 and macruby.

Then there are some issues with io.rb and process.rb I think. These are some dark, mysterious areas of Ruby behaviour that I am merely a happy user of, rather than an intrepid explorer.

So MacRuby runtime support within TextMate had a short, disappointing burst of life. If you are able to poke around and fix a few bugs, please try running the "Run" and "Run Rake Task" commands, observer the failure and see what you can do.