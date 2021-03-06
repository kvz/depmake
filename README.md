# depmake

## Warning: No longer used or maintained!

depmake is a collection of bash functions and conventions for creating
applications that can bundle all their code and dependencies inside a tar file.
The tar can be used to extract and run your app on any system (of the same
kernel / architecture).

depmake has a certain overlap with tools such as [chef][] and [puppet][], but
only contains features required to create deployable archives where version pinning of all libraries is paramount.

depmake also has a certain overlap with package managers such as [apt][] and
[pacman][], but is yet again laser focused on creating deployable archives.

However, [simple does not mean easy][]. depmake is a tool that allows you to
create simple deployment systems at the cost of more initial work.

[chef]: http://www.opscode.com/chef/
[puppet]: http://puppetlabs.com/
[apt]: http://en.wikipedia.org/wiki/Advanced_Packaging_Tool
[pacman]: https://wiki.archlinux.org/index.php/Pacman
[simple does not mean easy]: http://www.infoq.com/presentations/Simple-Made-Easy

## Overview

A typical depmake project allows you to check out a fresh copy of your project,
then:

```bash
cd my-project
source my-config.sh
cd deps && make
```

This will kick off a process in which all your dependencies are built and
installed into a folder called `stack`. Your `my-config.sh` then contains
some code like this:

```bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export STACK_DIR="${ROOT_DIR}/stack"

export ORIGINAL_PATH=${ORIGINAL_PATH:-$PATH}
export PATH="${ORIGINAL_PATH}:${STACK_DIR}/bin"
export CPPFLAGS="-I${STACK_DIR}/include"
export LDFLAGS="-L${STACK_DIR}/lib"
export LD_LIBRARY_PATH="${STACK_DIR}/lib"
export PKG_CONFIG_PATH="${STACK_DIR}/lib/pkgconfig"
```

This makes sure that in addition to the usual paths your systems looks
for binaries, shared libraries, etc., it will also consider the stuff insided
of the `stack` folder.

So effectively this creates a virtual environment that is activated by sourcing
a bash file, and de-activated by starting a new shell session.
