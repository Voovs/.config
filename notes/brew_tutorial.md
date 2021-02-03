
# Introduction
Homebrew, or Brew for short, is a package manager for macOS and Linux systems. While Linux distributions have many popular package managers, such as `pacman` and `apt-get`, most macOS users rely on Brew. Compared to Linux package managers, brew is particularly easy to learn. Even if you've never used a terminal before it's really worth it to learn Brew, especially since it'll only take a few minutes.
## Quick Start
Here's a usual day-to-day use of brew
```sh
# Getting the "exa" formula:
$ brew update
$ brew search exa
$ brew info exa
$ brew install exa
$ exa --version

# Getting MacVim, a full app:
$ brew update
$ brew search vim
$ brew info macvim
$ brew install --cask macvim
$ mvim newfile.txt

# Updating alacritty:
$ brew update
$ brew outdated
$ brew upgrade --cask alacritty
$ brew cleanup alacritty
```
## What is a package manager?
Let's look at an example. I want to download Anki, a very popular flashcard app. Anki isn't offered on the App Store, so I'll need to download it off the internet. Our steps will look like this, not just for Anki, any non-App Store app you download has a similar process:
1. Go to anki's website in a browser (https://apps.ankiweb.net/)
2. Find macOS under the downloads section
3. Wait for the installation file to download
4. Open the installation file from finder and accept the anti-virus prompt macOS gives
5. Drag the Anki.app into the Applications folder in the prompt macOS gives you
6. Move the installer file to trash, then empty the trash

That's so many steps! In fact, I had to go through them to remember how complicated it is to download apps on macos. Let's download the exact same app with Brew:
7. Open Terminal.app
8. Type `brew install anki`
That's it? I know right! It's so much easier, cleaner, and just outright better.

So a package manager is essentially a tool that downloads apps for you. Here are some other features:
- Keep track of all downloaded apps with the package manager
- Properly and fully uninstall apps
- Easily update apps, only when you want to update them
- Download all required dependencies automatically

Are there any disadvantages? Specifically for Brew, you're really unlikely to run into any problems. It's one of the best maintained codebases of all time and is incredibly easy to learn!
## Getting started
You'll first want to got to [HomeBrew's website](https://brew.sh/) and copy that very prominent line of code. Now open your terminal, likely Terminal.app if you've never used it, and paste the copied line of text in. Hit ENTER.

You may get a lot of lines of text. Don't worry, you can ignore all of them, unless there was an error downloading.

Now that you've got Brew, let's look at some commands. You can copy and paste these into your terminal, just make sure you don't copy that `$ ` in the front. That's just a convention to signal we're typing something in a terminal.

`$ brew --version`
	Let's try running this command! Simply type or copy/paste everything except the `$ ` at the start. If brew was successfully installed, it should print a version number!
## Commands Tutorial
Here we'll look at absolutely essential Brew commands, that you can't properly use Brew without. Yes, you'll have to memorize these, though you'll find this really easy after using them just a few times. 

If you ever forget a command, feel free to refer to the bottom of this file, where there are quick listings of all the relevent commands.

`$ brew update`
Running this command will update your Brew's database to the latest one. Since this is really important, say if a website changes where it puts its downloads, to make sure Brew downloads from the right place. In fact, Brew will automatically run this every time you install something!

Don't get this confused with `$ brew upgrade`! Running `$ brew update` will NOT update any of your installations. It only updates Brew's database. Further down we'll look at updating the installations too.

`$ brew list`
This command will show us all the apps we have installed. If you want to try it right now, it might not seem to do anything, since we haven't installed any apps yet!

`$ brew search anki`
Here, Brew will search its databases to find any apps with _"anki"_ in the name. This might take a few seconds. Feel free to replace _"anki"_ with any app you're interested in looking for. For example: `$ brew search google-chrome`. 
#### Formulae and Casks
Why's there a **Formulae** and a **Casks** heading when we search Brew?

This is really important to understand for Brew and likely the most complicated part. A **formula** can roughly be thought of as a command line tool. They're, usually, entirely run in a terminal and are pretty small. In fact Brew would be considered a **formula**! As you may have guessed, **formula** tend to be more technical and are often intended for people who already know what they're doing.

A **cask** is, usually, a graphical app, just as something you'd get from the App Store or download online. They tend to be much larger and don't require users to have a specific techinal skillset. Both Google Chrome and Anki are examples of such apps. 

Brew uses the metaphor of a distillery for many of its aspects. Think of a **formula** like a mug of beer, while a **cask** is an entire barrel.

`$ brew install exa`
This command will tell Brew to look for then install the **formula** _"exa"_. Try running it right now to see the output! _"exa"_ is really small and we'll remove it later so don't worry! 

In the **Summary** section you'll see where _"exa"_ was downloaded and its size. As a side note, want to see all of Brew's installations in Finder, you can find them under `/usr/local/Cellar/`. One of the great things about Brew is how it always installs all the files in one spot! Please do not edit this folder manually!!! You should be able to achieve everything through Brew's built-in commands.

`$ brew install --cask alacritty`
If you want to install a **cask**, remember that's an App, we'll need to add `--cask`. If you'd like to try, the command above will install _"alacritty"_. This particular **cask** is really small. You can replace _"alacritty"_ with any other cask, just watch out since most of them are pretty big.

`$ brew info exa`
Try running that exact command. Try replacing _"exa"_ with _"alacritty"_. This'll make Brew tell us all the information is has about _"exa"_. In this case, it doesn't matter if you're looking for a **formula** or **cask**...

Or does it? You'll notice that the info for _"alacritty"_ says it's 123B long. That's minuscule! Quite literally it's 123 letters with no spaces. That's since `$ brew install --cask alacritty` actually installed 2 things:
- Alacritty.app the **cask**, which is what Spotlight finds
- `alacritty` the **formula** which opens Alacritty.app

So when we `$ brew info alacritty` it finds two _"alacritty"_ installations! Since Brew always defaults to **formula**, it'll show us the info for the **formula** instead! Here is a very rare case where we'll want to run `$ brew info --cask alacritty` to get the right information. Do keep in mind this is so rare, I had to find a specific **cask** to demonstrate this, so you can drop `--cask` in most cases.
	
`$ brew uninstall exa`
This will uninstall the **formula** _"exa"_. Try running it. You'll notice it's pretty quick. Let's try `$ brew install exa` again. Interesting, Brew tells us we don't even need to download it again, since we already have the latest installer. That's since Brew won't uninstall the installer, so that we can reinstall without downloading! If you do want to uninstall the installer, check out the [advanced Brew section](#Advanced-tricks).

`$ brew uninstall --cask alacritty`
Uninstalls _"alacritty"_. You're probably starting to see a pattern here: add `--cask` after the command to deal with **casks**. That's completely right! The inverse of `--cask` is `--formula` and can be used in all the same places. We just typically drop `--formula` since that's Brew's default. 

`$ brew outdated`
Brew will list all the **formula** and **casks** which have newer version available. This is very useful to run before `$ brew upgrade` to make sure you aren't updating massive **casks** that could take a while.

`$ brew upgrade --cask alacritty`
Updates _"alacritty"_. While `$ brew update` will update your Brew database, it will not update any of your installations, since they can be quite huge. Of course `upgrade` will also update Brew's databases, to find out what is the latest version of all your installations.

If you want to update all your installations, then just run `$ brew upgrade` with no specifier. This might take a while, especially if you've got a lot of big **casks**. While the Brew community is a huge fan of updating everything, I'd caution you to consider how updating some apps changes them significantly. You may want to update on a single **cask** basis.

And that's it! Taking all that together, check out the [quick start guide](#Quick-Start) to see how you'll likely want to use these commands on a day-to-day basis. If this is your first time using a terminal congratulations! From this point on, you may want to reference the [commands section](#Brew-commands) to quickly recall what each command does.

## Advanced tricks
`$ man brew`
The complete guide to Brew, paginated. It may be very overwhelming, as it explains everything you can do with Brew, which very few of us actually need. It may however be helpful when you want to find a way to deal with a complicated situation.

`$ brew cleanup alacritty`
	As we mentioned for the `uninstall` subcommand, Brew does not remove installers or formula by default. It doesn't even remove them if you've updated to a newer version! While this may be useful if you plan on reinstalling old versions, it can make up a significant chuck of pointless storage being taken.

`cleanup` will remove all the old formula and installers and anything over 120 days old. You could run `$ brew cleanup` to cleanup all installations.

`$ brew list --formula | grep vim`
	Once you have a lot of **formula** installed, or particularly when they have a lot of dependencies, `$ brew list` isn't very helpful for finding things.
## Brew commands
Syntax:
`[--formula]` means `--formula` is optional and usually can be replaced by an optional `--cask`.
`{exa}` means you can put in any name, where "exa" is an example of a name you could put.
`[{exa}]` means you can optionally specify a name, an example of which is "exa". Usually not specifying a name will make Brew do it to everything.

`brew list [--formula]`
Lists all installed formula and casks
`brew search {exa}`
Searches taps for formula/cask
`$ brew info [--formula] {ext}`
Shows info for a formula/caks
`$ brew install [--formula] {exa}`
Installs a given formula/cask
`$ brew update`
Synchronizes your Brew with Brew servers. Note: This doesn't "update" your installations
`$ brew outdated [--formula]`
Lists all the outdated installations
`$ brew upgrade [--formula] [{alacritty}]`
"updates" your installations. Running with no arguments "updates" all installations
`$ brew cleanup [{alacritty}]`
Deletes outdated installers and related files
`$ man brew`
Shows all possible brew commands
