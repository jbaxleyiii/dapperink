



Apollos.fs._generateCollection("uploads", {
  store: {
    folder: "/uploads/images"
    bucket: "images.dapperink"
  }
})

Apollos.fs.uploads.allow({
  insert: -> true
  update: -> true
  remove: -> true
  download: -> true
})
