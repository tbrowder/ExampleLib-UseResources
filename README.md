NAME
====

**Module::Utils** - Demonstrates access to `$?DISTRIBUTION` "resources" for installed module distributions

SYNOPSIS
========

```raku
use Module::Utils;

demo # OUTPUT: «Usage: demo <number of lines [min 2] > | all␤»
```

DESCRIPTION
===========

**Module::Utils** aims to demonstrate use of the special variable, `$?DISTRIBUTION`, to access files included in an installed module distribution.

This module has a binary executable, `demo`, which, when executed, shows the results of using the variable to access the following file (all text files, but any type file should work):

    resources/file1      # <== listed in file C<META6.json> 
    resources/file2      # <== listed in file C<META6.json>
    resources/sdir/file3 # <== listed in file C<META6.json>
    ../lib/Module::Utils.rakumod  # <== listed in file C<META6.json>
    ../t/01-basic.rakutest  # <== B<NOT> listed in file C<META6.json> file

Notice some oddities in the file list above:

  * File 't/01-basic.t' 

    The file cannot be accessed because it is **not** listed in `META6.json`.

  * File '../lib/Module::Utils.rakumod' 

    The file's contents are available. The same is true for any file in the source code if it's listed in file `META6.json` in the `"resources:"` list. In that list its path must be shown **relative** to directory './resources'.

The provided subroutines may be used to provide users of the installed module with access to the contents of any file so listed as described above.

For reference, the applicable part of this distribution's `META6.json` is shown:

      "resources": [
        "file1",
        "file2",
        "sdir/file3",
        "../lib/Module/Utils.rakumod"
      ],

For the moment, authors must list the desired resources twice: once in the `META6.json` file and once in the source code's `resources` directory.

Eventally, `App::Mi6`'s `mi6` binary program's `build` command will ensure the `META6.json`'s `resources` list is the exact duplicate of the source `resources` directory so the author will not have to maintain two lists. (See issue #176 at [https://github.com/skaji/mi6](https://github.com/skaji/mi6).)

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

