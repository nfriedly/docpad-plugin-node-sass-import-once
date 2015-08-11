# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  fs = require('fs')
  path = require('path')
  sass = require('node-sass')
  importOnce = require('node-sass-import-once')
  async = require('async')

  # Define Plugin
  class NodesassPlugin extends BasePlugin
    # Plugin name
    name: 'nodesassimportonce'

    # Plugin config
    config:
      debugInfo: false
      renderUnderscoreStylesheets: false
      sourceMap: false

    # Prevent underscore
    extendCollections: (opts) ->
      # Prepare
      config = @config
      docpad = @docpad

      # Prevent underscore files from being written if desired
      if config.renderUnderscoreStylesheets is false
        @underscoreStylesheets = docpad.getDatabase().findAllLive(filename: /^_(.*?)\.(?:scss|sass)/)
        @underscoreStylesheets.on 'add', (model) ->
          model.set({
            render: false
            write: false
          })

    # Render some content
    render: (opts, next) ->
      # Prepare
      config = @config
      paths = []

      {inExtension,outExtension,file} = opts

      # If SASS/SCSS then render
      if inExtension in ['sass', 'scss'] and outExtension in ['css',null]
        # Fetch useful paths
        fullDirPath = file.get('fullDirPath')

        # Read sources & return content
        getSourcesContent = (sources, done) ->
          async.map sources.map(extendSourcePath), (source, next) ->
            fs.readFile path.join(fullDirPath, source), {encoding: 'utf8'}, next

        # Prepare the command and options
        cmdOpts = {}

        for prop of config.options
          cmdOpts[prop] = config.options[prop]

        if fullDirPath
          paths.push(fullDirPath)


        cmdOpts.includePaths = if cmdOpts.includePaths then cmdOpts.includePaths.concat(paths) else paths

        if config.debugInfo and config.debugInfo isnt 'none'
          cmdOpts.sourceComments = config.debugInfo
          cmdOpts.file = file.attributes.fullPath
        else
          cmdOpts.data = opts.content

        cmdOpts.importer = importOnce

        # Spawn the appropriate process to render the content
        sass.render cmdOpts, (err, result) ->
          return next(err) if err

          css = result.css

          if result.map and result.map.sources
            map = result.map
            getSourcesContent map.sources, (err, sourcesContent) ->
              return next(err) if err

              map.sourcesContent = sourcesContent
              sourceMap = new Buffer(JSON.stringify(map)).toString('base64')
              css = css.replace(/\/\*# sourceMappingURL=.*\*\//, '/*# sourceMappingURL=data:application/json;base64,' + sourceMap + '*/')

              opts.content = css
              next()
      else
        next()
