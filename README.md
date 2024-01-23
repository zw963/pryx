# Pryx [![CI](https://github.com/zw963/pryx/actions/workflows/ci.yml/badge.svg)](https://github.com/zw963/pryx/actions/workflows/ci.yml) [![Gem Version](https://badge.fury.io/rb/pryx.svg)](http://badge.fury.io/rb/pryx) ![](https://ruby-gem-downloads-badge.herokuapp.com/pryx?type=total)

Three Virtues of a Programmer: Laziness, Impatience, and Hubris. -- Larry Wall, the author of Perl Programming language.

## Getting Started

[NOTICE] Check [What's new in Ruby 3.2's IRB?](https://st0012.dev/whats-new-in-ruby-3-2-irb) for the introduced new feature of Ruby 3.2 IRB which includes part of feature this gem provides.

Don't add this gem into bundler's Gemfile.

Instead, install it directly via RubyGems

    $ gem install pryx
	
Then user can use pryx cross all your's project.	

## Usage

At first, it is just pry, with more extensions.

you can always run it with `pryx`.

```sh
 ╰─ $ pryx
[1] pry(main)> ? Array#each_with_object

From: enum.c (C Method):
Owner: Enumerable
Visibility: public
Signature: each_with_object(arg1)
Number of lines: 20

Calls the block once for each element, passing both the element
and the given object:

  (1..4).each_with_object([]) {|i, a| a.push(i**2) }
  # => [1, 4, 9, 16]

  {foo: 0, bar: 1, baz: 2}.each_with_object({}) {|(k, v), h| h[v] = k }
  # => {0=>:foo, 1=>:bar, 2=>:baz}

With no block given, returns an Enumerator.

static VALUE
enum_each_with_object(VALUE obj, VALUE memo)
{
    RETURN_SIZED_ENUMERATOR(obj, 1, &memo, enum_size);

    rb_block_call(obj, id_each, 0, 0, each_with_object_i, memo);

    return memo;
}
[2] pry(main)> 

```

Second, it add a new `Kernel#pry!`, you can use it instead of `binding.pry`.
 It's not just an alias, there are more.

Before use it, you need set `RUBYOPT` variable.

You can do this two way in a terminal.

```sh
$: export RUBYOPT+=' -rpryx'   # For BASH only
$: export RUBYOPT="$RUBYOPT -rpryx" # For others shell
$: ruby your_file.rb              # add pry! in your_file for start pry session

```

or Run your's code directly use:


```sh
$: RUBYOPT+='-rpryx' ruby your_file.rb  # add pry! in your_file for start pry session
```

Following is a example, assume there is a `test.rb` with content:

```rb
# test.rb
3.times do
  pry!
  puts 'hello'
end
```

Then, when you run `RUBYOPT='-rpryx' ruby test.rb`

![pry.png](images/pry!.png)

You can even connect to a pry session started from remote or background process 
use http connection.

![pry_remote.png](images/pry_remote.png)

Until now, you've only seen the tip of the iceberg, please have a try.


the preferred way to use pryx is add `export RUBYOPT+=' -rpryx'` to system start script.

It should almost not affect your's code too much, only special methods defined into Kernel#, 
no any gem be required before you invoke those added methods.

## useful command which added directly to Kernel#

### Kernel#pry!

start a pry session, this session only can be intercept once if add into a loop.
when used with a rails/roda web server, it only intercept one per request.

we have IRB equivalent, named `irb!`, though, only a little feature support it.

Following feature both available when start a Pry or IRB session:

1.  Add `Kernel#ls1`(use ls1 to avoid conflict with pry builtin ls command), see [looksee](https://github.com/oggy/looksee)
2.  Use `ap` for pretty print. see [awesome-print](https://github.com/awesome-print/awesome_print)
3.  Use `Clipboard.copy` or `Clipboard.paste` to interactive with system clipboard. see [clipboard](https://github.com/janlelis/clipboard)

Following feature available only for a Pry session:

1.  Add `next/step/continue/up/down` command for debug, use [pry-nav](https://github.com/nixme/pry-nav) [pry-stack_explorer](https://github.com/pry/pry-stack_explorer)
2.  Add `$/?` command for see source, see [pry-doc](https://github.com/pry/pry-doc)
3.  pry-remote debug support. you still use `pry!` no changes, it will use `pry-remote` automatically
    if current ruby process was running on backround, then, it will use pry-remote, and listen on 0.0.0.0:9876,
    Then, you can connect to it from another terminal! see [pry-remote](https://github.com/Mon-Ouie/pry-remote)
4.  Add `pa` command, see [pry-power_assert](https://github.com/yui-knk/pry-power_assert)
5.  Add `hier` command for print the class hierarchies, see [pry-hier](https://github.com/phaul/pry-hier)
6.  Add `pry-aa_ancestors` command for print the class hierarchy, see [pry-aa_ancestors](https://github.com/tbpgr/pry-aa_ancestors)
7.  Add `up/down/frame/stack` command, see [pry-stack_explorer](https://github.com/pry/pry-stack_explorer)
8.  Add `yes` or `y` command, see [pry-yes](https://github.com/christofferh/pry-yes)
9.  Add `pry-disam`, Check following screenshot for a example:

![pry-disasm](images/disasm.png)

### Kernel#pry1 Kernel#pry2  (sorry for the bad name, please create a issue you have a better one)

pry2 do nothing, but it will be interceptd and start a pry session only after pry1 is running.

I haven use this hack for avoid pry session start on working place.

You know what i means.

### Kernel#irb1 Kernel#irb2 

IRB equivalent for pry1, pry2
we have irb1 and irb2 too.

### Kernel#pry3

It just normal `binding.pry`, that is, will always be intercept if code can reach.
but above plugins and libraries all correct configured.

we have another Kernel#pry?, which enable `pry-state` automatically, see [pry-state](https://github.com/SudhagarS/pry-state)

### Add CLI command, rescue, kill-pry-rescue, pryx, irbx, pry!

`rescue` and `kill-pry-rescue` come from `pry-rescue` gem, it not load by default, but you can use rescue command from command line directly.
see [pry-rescue](https://github.com/ConradIrwin/pry-rescue)

pryx is same as pry, but, with plugins and libraries correct configured, it will load `./config/environment.rb` if this file exists.

irbx is same things for irb.

`pry!` just a alias to `binding.pry`, but, if process is running on background, it a alias to `binding.remote_pry('0.0.0.0', 9876)`, 
you can specify host or port manually, like this: `pry!(host: '192.168.1.100')`. 
in another terminal, you can run `pry!` directly to connect to it use IP + port.

e.g. assume your's pry-remote server started background on another host(192.168.1.100), port 9876
It maybe in container, you can connect remote pry like this:

```sh
$: pry! -s 192.168.1.100 -p 9876
```

## Philosophy

This gem is design to Minimal impact on target ruby code, in fact, after `require 'pryx'` or `RUBYOPT='-rpryx'`
(they do same thing), only several instance method be defined on Kernel, and several gems add to $LOAD_PATH, 
but not load, ready to require it, no more. so, it should be safe to use it, either affect performance nor
namespace/variables etc.

But, you should only use it in development, though, it was tested is run in container(alpine) too.

## Limit
  
  2. Pry's show auto-watch when not work, because `Enter` key rebinding to `run the last command`.
     i consider this is more useful, you can always use `w` alias to see the watch changes.

## Support

  * MRI 2.6+

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
