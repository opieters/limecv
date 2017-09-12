# limecv <img src="src/images/limecv-icon.png" alt="limecv project icon" width="40px"/>

`limecv` is a document class to typeset curriculum vitæ in LaTeX.

The design of this document class is detailed in [a series of blog posts][blog].  

Example CV:

<div>
    <img src="images/cv.png" alt-="CV example" width="300px"/>
    <img src="images/cover_letter.png" alt-="cover letter example" width="300px"/>
</div>

## Installation

The package is available from CTAN, soo install this document class using your favourite package manager. 

After installing this package, make sure you have the following fonts installed:

* [FontAwesome][FA]
* [Fira][fira]

The following packages need to be installed on your system they are all available on CTAN: 
`kvoptions`,
`ifxetex`,
`ifluatex`,
`xparse`,
`calc`,
`xcolor`,
`tabularx`,
`hyperref`,
`url`,
`parskip`,
`xstring`,
`xkeyval`,
`tikz`,
`graphicx`,
`fontspec` (XeLaTeX and LuaLaTeX only) and
`fontawesome`.

## Documentation

The class documentation can be found [here][docs].

Alternatively, the documentation can also be created by running `pdflatex limecv.dtx` in the source folder.

## Examples

To compile the examples in `/examples/`, install the package from CTAN or compile from source by running: `pdflatex limecv.ins` from the `/src/` folder and copy the resulting `limecv.cls` file to the `/examples/` folder.

## Roadmap

Below is a list of upcoming features and important todo's. After these have been resolved, the first stable release will be released.

- [x] Publish to CTAN.
- [x] Initial release.
- [x] LuaLaTeX support.
- [x] LaTeX support.
- [ ] Cleaned code.
- [x] `.dtx` source code format.
- [ ] Real testing by third party.

## Licence

LPPL v1.3c See LICENSE file.

© 2017 Olivier Pieters

[blog]: https://olivierpieters.be/blog/archive/tag/business-card
[FA]: http://fontawesome.io
[fira]: https://github.com/mozilla/Fira
[docs]: http://ctan.org/tex-archive/macros/generic/limecv/limecv.pdf
