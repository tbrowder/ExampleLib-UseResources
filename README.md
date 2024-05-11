[![Actions Status](https://github.com/tbrowder/ExampleLib-UseResources/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/ExampleLib-UseResources/actions) [![Actions Status](https://github.com/tbrowder/ExampleLib-UseResources/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/ExampleLib-UseResources/actions) [![Actions Status](https://github.com/tbrowder/ExampleLib-UseResources/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/ExampleLib-UseResources/actions)

NAME
====

**ExampleLib::UseResources** - Provides routines to access $?DISTRIBUTION rsources for installed module distributions

SYNOPSIS
========

```raku
use Module::Utils;
# use its routines to query and download your module's repository contents
```

DESCRIPTION
===========

This package provides module authors with a module Rakumod file to copy and paste into their own module distribution repo that will enable them to use the special variable, `$?RESOURCES`, to access files included in an installed module distribution.

Use the module in your code
---------------------------

To use it in your module repo 'MyModule', copy this module's '/lib/ExampleLib/UseResources.rakumod' file to a unique module in your repo's 'lib' directory, rename it as appropriate, and update its inside name accordingly. Note there is a special binary executable installed with this module to do that for you:

    copy-resources-module file=<desired module file name> module=<desired module name>

The process also creates a test file for that installation. Note the files are created in the current directory and you will have to be put it in place manually.

Module details
--------------

For example, say your module's file structure includes the following files:

    resources/file1         # <== listed in file 'META6.json'
    resources/file2         # <== listed in file 'META6.json'
    resources/sdir/file3    # <== listed in file 'META6.json'
    ../lib/MyModule.rakumod # <== listed in file 'META6.json'
    ../t/01-basic.rakutest  # <== NOT listed in the 'META6.json' file

Notice some oddities in the file list above:

  * File 't/01-basic.rakutest'

    The file *cannot* be accessed because it is *not* listed in the `META6.json` file.

  * File '../lib/MyModule.rakumod'

    The file's contents are available. The same is true for any file in the source code *ifi* it's listed in file `META6.json` in the `"resources:"` list. In that list its path *must* be shown *relative* to directory './resources' as it is in the example.

For the moment, authors must list the desired resources twice: once in the `META6.json` file and once in the source code's `resources` directory.

Eventally, `App::Mi6`'s `mi6` binary program's `build` command will ensure the `META6.json`'s `resources` list is the exact duplicate of the source `resources` directory so the author will not have to maintain two lists. (See issue #176 at [https://github.com/skaji/mi6](https://github.com/skaji/mi6).)

Routines currently available
============================

CREDITS
=======

Thanks to Nick Logan (@ugexe on Github and IRC #raku) for his advice and his powerful `zef` program.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

