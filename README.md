# Nanny

Nanny is a little package that will help you to create UI walkthroughs

## Usage Basics

Firstly you'll need to add `data-nanny-html` attributes to the blocks where you want
the helper texts to appear

    :html
    <div data-nanny-html="This block does some useful thing">
      Very useful block of stuff
    </div>
    <div data-nanny-html="This block does something else">
      Some other block
    </div>

You also can specify at which side of your block the popup should appear

    :html
    <div data-nanny-html="..." data-nanny-position="left">....</div>
    <div data-nanny-html="..." data-nanny-position="bottom">....</div>

Once you're done with that, just initialize the `Nanny` object through the `Lovely`
interface and call the `Nanny#start()` method

    :js
    Lovely(['nanny-1.0.0'], function(Nanny) {
      // when you're ready
      var nanny = new Nanny({options: 'here'});
      nanny.start();
    });

This will start showing the helper texts over the marked blocks

## Options

 * `scope`      (document.body)  - working scope element
 * `timeout`    (4000)           - how long each piece should hang
 * `position`   ('top')          - default message position
 * `loop`       (true)           - whether to loop or not through the helpers
 * `html`       ('')             - default html content
 * `fxName`     ('fade')         - name of the visual effect to use
 * `fxDuration` ('normal')       - visual effect duration

## API Reference

The `Nanny` class is inherited from the standard `dom.Element` class and has all the same API.
Plus it has two additional methods for starting and stopping the popups show

 * `#start()` - to start the show
 * `#stop()` - is for stopping the show

## Events

`Nanny` objects fire the following list of events

 * `show` - when it appears at a marked block
 * `hide` - when it gets hidden
 * `start` - when the show starts
 * `stop` - when the show get stopped



## Copyright And License

This project is released under the terms of the MIT license

Copyright (C) 2012 Nikolay Nemshilov