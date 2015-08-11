module.exports = {
  plugins: {
    nodesassimportonce: {
      options: {
        outputStyle: 'compressed',
        precision: 3,
        includePaths: [__dirname + "/src/documents/includePath"]
      }
    }
  }
};
