Smalltalk logStdOutDuring: [ :logger |
    logger nextPutAll: ('## Pharo Smalltalk Interop Server ##: {1}' format: {SisServer current}); cr.
]
