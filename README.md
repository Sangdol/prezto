This is my version of [Prezto](https://github.com/sorin-ionescu/prezto)

Installation
------------

Prezto will work with any recent release of Zsh, but the minimum required
version is 4.3.17.

  1. Launch Zsh:

        zsh

  2. Clone the repository:

        git clone --recursive https://github.com/Sangdol/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  3. Create a new Zsh configuration by copying the Zsh configuration files
     provided:

        ```
        setopt EXTENDED_GLOB
        for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(N); do
          ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
        done
        ```

        cd ~/Library/KeyBindings && ln -s ~/.zprezto/mac/DefaultKeyBinding.dict

  4. Set Zsh as your default shell:

        chsh -s /bin/zsh

  5. Open a new Zsh terminal window or tab.

License
-------

(The MIT License)

Copyright (c) 2009-2011 Robby Russell and contributors.

Copyright (c) 2011-2015 Sorin Ionescu and contributors.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[1]: http://www.zsh.org
[2]: http://i.imgur.com/nrGV6pg.png "sorin theme"
[3]: http://git-scm.com
[4]: https://github.com
[5]: http://gitimmersion.com
[6]: http://gitref.org
[7]: http://www.bash2zsh.com/zsh_refcard/refcard.pdf
[8]: http://grml.org/zsh/zsh-lovers.html
