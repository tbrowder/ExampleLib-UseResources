[![Actions Status](https://github.com/tbrowder/ExampleLib-UseResources/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/ExampleLib-UseResources/actions) [![Actions Status](https://github.com/tbrowder/ExampleLib-UseResources/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/ExampleLib-UseResources/actions) [![Actions Status](https://github.com/tbrowder/ExampleLib-UseResources/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/ExampleLib-UseResources/actions)

NAME
====

**ExampleLib::UseResources** - Provides routines to access $?DISTRIBUTION rsources for installed module distributions

SYNOPSIS
========

```raku
# Copy and rename its module and test file into your
# module's repo. Then use its routines to query and
# download your installed module's repository contents.
$ copy-resources-module file=Utils  mod=Module::Utils
# OUTPUT
```

DESCRIPTION
===========

This package provides module authors with a Rakumod module file to copy and paste into their own module distribution repo that will enable them to use the special variable, `$?DISTRIBUTION`, to access files included in an installed module distribution.

Use the module in your code
---------------------------

To use it in your module repo 'MyModule', copy this module's '/lib/ExampleLib/UseResources.rakumod' file to a unique module in your repo's 'lib' directory, rename it as appropriate, and update its inside name accordingly. Note there is a special binary executable installed with this module to do that for you:

    copy-resources-module file=<desired module file name> mod=<desired module name>

The process also creates a test file for that installation. Note the files are created in the current directory, and you will have to put them in their proper place manually.

Module details
--------------

For example, say your module's file structure includes the following files:

    resources/file1         # <= exists, listed in 'META6.json'
    resources/file2         # <= exists, listed in 'META6.json'
    resources/sdir/file3    # <= exists, listed in 'META6.json'
    ../lib/MyModule.rakumod # <= exists, listed in 'META6.json'
    ../t/01-basic.rakutest  # <= exists, NOT listed in 'META6.json'
    resources/file4         # <= NONE EXISTENT, BUT listed in 'META6.json'

In general, any *existing* file in the distribution's repository directory is accessible via use of this module *if and only if* its path, relative to the 'resources' directory is listed in the *resources* section of the 'META6.json'. Note it does *not* have to be listed in the 'resources' directory as long as its relative path is correctly listed in 'META6.json'.

Following are examples illustrating those rules:

  * File 'resources/file4'

    ERROR: The file *cannot* be accessed because it does not exist, even though it is listed in the `META6.json` file.

  * File 't/01-basic.rakutest'

    ERROR: The file *cannot* be accessed because it is *not* listed in the `META6.json` file.

  * File '../lib/MyModule.rakumod'

    ODDITY: The file's contents are available because its relatiive path is correctly listed in the 'META6.json' file.

For the moment, authors must list the desired resources twice: once in the `META6.json` file and once in the source code's `resources` directory.

Limitation relief
-----------------

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

