# Pryx [![Build Status](https://travis-ci.com/zw963/pryx.svg?branch=master)](https://travis-ci.com/zw963/pryx) [![Gem Version](https://badge.fury.io/rb/pryx.svg)](http://badge.fury.io/rb/pryx)

Three Virtues of a Programmer: Laziness, Impatience, and Hubris. -- Larry Wall, the author of Perl Programming language.

## Getting Started

Don't add this gem into bundler's Gemfile.

Instead, install it directly via RubyGems

    $ gem install pryx

## Usage

Before use it, you need set `RUBYOPT` variable.

You can do this two way in a terminal.

```sh
$: export RUBYOPT+=' -rpryx'
$: ruby your_file.rb              # add pry! in your_file for start pry session

```

or Run your's code directly use:

```sh
$: RUBYOPT+='-rpryx' ruby your_file.rb  # add pry! in your_file for start pry session
```

Then, try add `pry!` into your's ruby code, then run it, have fun!

## useful command add directly to Kernel#

### pry!   
   
start a pry session, this session only can be intercept once if add into a loop.
when used with a rails/roda web server, it only intercept one per request.

we have IRB equivalent, named `irb!`, for use more nice feature, use following code instead:

```sh
$: RUBYOPT+='-rpryx_irb' ruby your_file.rb # add irb! in your_file for start pry session
```

Following feature both available when start a Pry or IRB session:

1.  add `next/step/up/down` command for debug, use [break](https://github.com/gsamokovarov/break)
2.  add `Kernel#ls1`(use ls1 to avoid conflict with pry builtin ls command), see [looksee](https://github.com/oggy/looksee)
3.  Use AwesomePrint for printer. see [https://github.com/awesome-print/awesome_print]

Following feature only available when start a Pry session:

1.  add `$/?` command for see source, see [pry-doc](https://github.com/pry/pry-doc)
2.  pry-remote debug support. you still use `pry!` no changes, it will use `pry-remote` automatically
    if current ruby process was running on backround, then, it will use pry-remote, and listen on 0.0.0.0:9876,
    Then, you can connect to it from another terminal! see [pry-remote](https://github.com/Mon-Ouie/pry-remote)
3.  add `pa` command, see [pry-power_assert](https://github.com/yui-knk/pry-power_assert)
4.  add `hier` command for print the class hierarchies, see [pry-hier](https://github.com/phaul/pry-hier)
5.  add `pry-aa_ancestors` command for print the class hierarchy, see [pry-aa_ancestors](https://github.com/tbpgr/pry-aa_ancestors)
6.  add `up/down/frame/stack` command, see [pry-stack_explorer](https://github.com/pry/pry-stack_explorer)
2.  add `yes` or `y` command, see [pry-yes](https://github.com/christofferh/pry-yes)
   
### pry1 pry2  (sorry for this bad name, please create a issue you have a better one)

pry2 do nothing, but it will be interceptd and start a pry session only after pry1 is running.

I haven use this hack for avoid pry session start on working place.

You know what i means.

### irb1 irb2 

IRB equivalent for pry1, pry2
we have irb1 and irb2 too.

### pry3

It just normal `binding.pry`, that is, will always be intercept if code can reach.
but above plugins and libraries all correct configured.

we have another Kernel#pry?, which enable `pry-state` automatically, see [pry-state](https://github.com/SudhagarS/pry-state)

### we have two binary, pryx, irbx

pryx is same as pry, but, with plugins and libraries correct configured.

irbx is same for irb.

## Philosophy

This gem is design to maximum limit take effect current ruby program, so, it should be safe to use it.
But, you should only use it when development, though, it was tested when use in docker-compose container too.

## Support

  * MRI 2.2+

## History

  See [CHANGELOG](https://github.com/zw963/pryx/blob/master/CHANGELOG) for details.

## Contributing

  * [Bug reports](https://github.com/zw963/pryx/issues)
  * [Source](https://github.com/zw963/pryx)
  * Patches:
    * Fork on Github.
    * Run `gem install --dev pryx` or `bundle install`.
    * Create your feature branch: `git checkout -b my-new-feature`.
    * Commit your changes: `git commit -am 'Add some feature'`.
    * Push to the branch: `git push origin my-new-feature`.
    * Send a pull request :D.
	
	Not listed famous pry plugins is welcome!!

## license

Released under the MIT license, See [LICENSE](https://github.com/zw963/pryx/blob/master/LICENSE) for details.
