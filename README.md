# thisisbad

## A dumb Ruby -> Python bridge

Call Python functions from Ruby, as long as the function arguments and return
values are JSON-serializable. Read the source. It's a neat trick :)

I use this gem in a [video](https://vimeo.com/37931449) demonstrating some
techniques I found while practicing test-driven development.

There's a real [Ruby -> Python bridge](http://rubypython.rubyforge.org/) being
developed that looks really impressive. It seemed to clobber RSpec when I tried
it, so I wrote thisisbad to record the video.
