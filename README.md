# [SASS/SCSS](http://sass-lang.com/) Plugin for [DocPad](https://docpad.org)

[![NPM version](https://badge.fury.io/js/docpad-plugin-nodesassimportonce.png)](https://npmjs.org/package/docpad-plugin-nodesassimportonce "View this project on NPM")
[![Dependency Status](https://gemnasium.com/nfriedly/docpad-plugin-nodesassimportonce.png)](https://gemnasium.com/nfriedly/docpad-plugin-nodesassimportonce)
[![Build Status](https://travis-ci.org/nfriedly/docpad-plugin-nodesassimportonce.png?branch=master)](https://travis-ci.org/nfriedly/docpad-plugin-nodesassimportonce)

> Adds support for the [SCSS](http://sass-lang.com/) CSS pre-processor to [DocPad](https://docpad.org).

Uses [node-sass](https://www.npmjs.com/package/node-sass) and [node-sass-import-once](https://www.npmjs.com/package/node-sass-import-once) under the hood.

Built primarily for compatibility with [IBM-Watson/design-guide](https://github.com/IBM-Watson/design-guide). 

Based on [docpad-plugin-nodesass](https://www.npmjs.com/package/docpad-plugin-nodesass) by [Jimmy King](https://github.com/jking90).

Convention:  `documents/css/*.css.scss`

## Install

```bash
npm install --save docpad-plugin-nodesassimportonce
```

## Configuring

Example:

```coffee
    plugins:
        nodesassimportonce:
            debugInfo: 'map'
            options:
                outputStyle: 'compact'
                includePaths: ['src/files/foo', 'src/raw/bar']
                importOnce: 
                    index: false
                    css: false
                    bower: false
			    
```

### Debug Info

debugInfo: false|'normal'|'map'

`normal` will print comments in the output css that indicates the source file name and line number. `map` will produce a sourcemap. Using either of these options instead of `none` will prevent you from being able to run any other process on the file (e.g. `FILE.css.scss.eco`), because `debugInfo` requires passing an actual file instead of `stdin`.


### Options

The options object is passed to [node-sass](https://github.com/sass/node-sass#options) and [node-sass-import-once](https://github.com/at-import/node-sass-import-once#usage), so any options they support can be included here.


## Contributing
[You can discover the contributing instructions inside the `Contributing.md` file](https://github.com/nfriedly/docpad-plugin-nodesassimportonce/blob/master/Contributing.md)


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
